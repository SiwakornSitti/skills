## Client and context

- Create the client once during startup and close it during graceful shutdown; never create connections per request.
- Load endpoint, TLS, credentials, database or namespace, pool/concurrency limits, and timeouts from configuration.
- Pass context.Context to every command and preserve cancellation and deadlines.
- Use the valkey-go API and response types from the pinned dependency version. Do not copy go-redis method calls or error handling into Valkey code without compiling and testing them.
- Check connectivity at startup only when Valkey is required. For optional caching, define safe degraded behavior instead.
