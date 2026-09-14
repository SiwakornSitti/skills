## Reliability and safety

- Valkey is not the source of truth for database-backed data. Follow golang-cache for cache-aside reads, database-first writes, invalidation, TTLs, and fallback.
- Use atomic commands or client-supported transactions for coupled changes. A read followed by a write is not atomic.
- For locks, use an owner token and bounded lease; release only the lock owned by the current worker. Test expiry, cancellation, and process pause behavior.
- Make stream and queue consumers idempotent and define acknowledgement, retry, and dead-letter behavior. Pub/sub remains lossy and ephemeral.
- Wrap errors with operation and namespace context. Log once at the inbound boundary per golang-apperror-logging.
