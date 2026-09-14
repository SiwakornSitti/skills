## Caching

- Follow golang-cache for cache-aside reads, database-first writes, invalidation, bounded TTLs, and value-copy isolation.
- Redis is not the source of truth. Cache outage fallback must be explicit, and cache failure must not silently turn a successful database write into a failed write.
- Prevent stampedes only when measurement or load shape justifies it. Keep the simplest correct approach first.
- Never use a cache key as an authorization decision; authorization still happens against trusted domain data.
