# Load, failure, and security controls

- Bound the maximum value size and collection size. Do not cache unbounded query results.
- Prevent a hot-key stampede only when traffic justifies it; use request coalescing or a short lock with a clear timeout and recovery path.
- Add jitter to large groups of identical TTLs when synchronized expiry could create a load spike.
- Treat cache latency, hit ratio, miss ratio, evictions, serialization failures, and backend errors as operational signals.
- Keep cache failure handling separate from source-of-truth failure handling. A cache outage needs a tested, explicit fallback or a deliberate fail-closed policy.
- Include tenant or principal scope in the key where required, and authorize using trusted domain data.
- Do not cache secrets, credentials, tokens, or sensitive personal data unless retention, encryption, access, and deletion requirements are explicit.

The cache is never the source of truth. If reads fail, use the source system
when the request can safely tolerate it. Surface cache writes or deletes as
warnings without hiding a successful source-system write.

## Examples

### Bound values and collections

Reject or skip entries that exceed the agreed limit, and never cache an entire
unbounded result set:

```go
if len(items) > maxCachedItems || estimatedSize(items) > maxCachedBytes {
    return items, nil
}
return items, cache.Set(ctx, key, items, ttl)
```

The exact limits belong in service configuration only when they must vary by
deployment; otherwise keep them as documented constants.

### Cache outage with read fallback

For data that permits fail-open reads, return the source value when the cache
backend is unavailable:

```go
value, err := cache.Get(ctx, key)
if err == nil && value != nil {
    return value, nil
}
return repository.Find(ctx, id)
```

Record the cache failure as a bounded diagnostic event, but do not return a
stale or fabricated value and do not hide a repository error.

### Stampede control

For a measured hot key, use cache-aside with request coalescing:

1. Read the cache before joining the group for the fast hit path.
2. On a miss, join a `singleflight` group keyed by the canonical cache key.
3. Double-check the cache inside the group before reading the source.
4. Let the leader load the source and populate the cache; waiting callers share its result.

```go
if value, err := cache.Get(ctx, key); err == nil && value != nil {
    return value, nil
}

value, err, _ := flight.Do(key, func() (Value, error) {
    if value, err := cache.Get(ctx, key); err == nil && value != nil {
        return *value, nil
    }
    return loadAndPopulate(ctx, key)
})
```

The outer read avoids coordination on hits. The inner read is defensive: a
writer, another process, or another refill path may populate the cache between
the two reads. Use a bounded group and preserve source fallback behavior; an
unbounded wait turns one cache miss into a new bottleneck.

### Bounded telemetry

Good metric dimensions:

```text
cache_operation_total{operation="get", outcome="hit"}
cache_operation_total{operation="get", outcome="miss"}
cache_operation_total{operation="set", outcome="error"}
```

Do not use the cache key, user ID, raw error text, or request payload as a
metric label. Keep those details out of logs too unless they are explicitly
redacted and needed for diagnosis.

### Sensitive data

Safe candidates are usually public or low-sensitivity projections:

```text
account:v1:summary:<id> -> {displayName, status}
```

Do not cache passwords, bearer tokens, payment details, or a response whose
authorization depends on a principal that is absent from the key.
