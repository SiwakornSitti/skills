# Cluster overview

Valkey Cluster distributes hash slots across nodes. A cluster-aware client must
route commands to the node that owns the key and refresh its view when the
topology changes.

## Establish before coding

- Valkey server version and `valkey-go` version.
- Startup nodes or cluster endpoint and TLS/authentication requirements.
- Whether the service uses cache keys, locks, transactions, scripts, or other
  multi-key operations.
- Which operations may fail when keys are on different slots.
- Whether the service can tolerate partial availability or must fail closed.

Do not infer cluster behavior from a standalone Redis-compatible test. The
deployment topology is part of the application contract.

## Application boundary

- Create one cluster-aware client during startup and close it during graceful
  shutdown.
- Keep key construction centralized and versioned.
- Treat routing errors as operational failures with command and key namespace
  context, without logging secret values.
- Use bounded timeouts and preserve caller cancellation for every command.
- Do not manually route commands or calculate slots when the pinned client
  already owns that behavior.

Cluster does not make a multi-step read-then-write atomic. Use a supported
single-key command or a slot-compatible transaction/script when atomicity is
required.
