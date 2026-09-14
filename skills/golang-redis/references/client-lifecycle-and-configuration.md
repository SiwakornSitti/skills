## Client lifecycle and configuration

- Construct one client or pool during startup and close it during graceful shutdown.
- Configure address, credentials, database, pool limits, dial/read/write timeouts, and TLS through service configuration; never hard-code credentials.
- Ping during startup only when Redis is required for safe startup. If Redis is an optional cache, allow startup and define degraded read/write behavior.
- Pass context.Context to every command. Context cancellation must stop waiting for Redis.
- Keep Redis-specific types behind an adapter or port when domain code does not need Redis semantics.
