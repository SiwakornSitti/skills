# Cache strategy

Add a cache only for a measured or stated read-cost problem. Read the
repository, its write paths, and existing cache decorator before changing
cache behavior.

| Situation | Strategy |
| --- | --- |
| Read-heavy data that can tolerate bounded staleness | Cache-aside |
| Every successful write must immediately refresh the cache | Write-through or database-first write followed by cache update |
| Durable writes must not depend on the cache | Database as source of truth, cache invalidation or refresh after commit |
| Volatile coordination or locks | Dedicated coordination store, not an application-data cache |

For this repository, prefer cache-aside around a domain repository:

1. Build the canonical key and attempt a read.
2. On a miss, read the source of truth.
3. Return the source value and populate the cache with a bounded TTL.
4. After a successful write, update or invalidate affected entries.

Define the owner, source of truth, freshness target, consistency requirement,
failure mode, and expected capacity before implementation. Use cache-aside by
default. Avoid write-behind for business data because an acknowledged cache
write can be lost before durable persistence.

Do not cache responses whose authorization, tenant scope, or freshness cannot be
represented in the key and invalidation policy.

For a concrete backend, read [golang-redis](../../golang-redis/SKILL.md) or
[golang-valkey](../../golang-valkey/SKILL.md).
