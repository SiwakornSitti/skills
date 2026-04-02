# Caching

- **Proper Use Case:** Only implement caching for data that is frequently accessed, expensive to compute, or read-heavy. Avoid caching highly volatile or sensitive data without a strict TTL (Time To Live).
- **Batch Operations:** When accessing or setting multiple keys, **must** use batch commands (e.g., Redis `MGET`, `MSET`, or pipelining) to minimize network round trips and improve performance.
- **Cache Stampede Prevention:** Use techniques like locking (mutexes) or probabilistic early expiration (e.g., XFetch) to prevent multiple goroutines from querying the database simultaneously when a popular cache key expires.
- **Graceful Fallback:** If the cache server (e.g., Redis) is down or unreachable, the application **must** log the error and gracefully fall back to querying the primary database. Do not fail the entire request just because the cache is unavailable.
- **Providers:** Use a robust cache provider like Redis or an in-memory cache (e.g., `ristretto`, `hashicorp/golang-lru`).
- **Eviction Policy:** You **must** explicitly define a clear eviction policy (e.g., LRU - Least Recently Used, LFU, or strict TTL) for all caches to prevent memory exhaustion and Out Of Memory (OOM) crashes.
- **Location:** Shared caching infrastructure (clients, wrappers) should be placed in appropriate shared packages within `/internal`.
