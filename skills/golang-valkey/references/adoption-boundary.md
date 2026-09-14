## Adoption boundary

- Confirm the target Valkey version, topology, TLS/authentication mode, cluster or sentinel behavior, and managed-service support before choosing client options.
- Decide whether the service needs Valkey-specific behavior or only Redis-compatible commands. For compatibility-only caching, the existing golang-cache and go-redis path may be sufficient.
- Keep the client behind a package adapter when the rest of the service should remain independent of the vendor client.
- Do not add both go-redis and valkey-go to the same path without a measured migration or compatibility requirement. Keep one owner for client creation, health checks, and shutdown.
