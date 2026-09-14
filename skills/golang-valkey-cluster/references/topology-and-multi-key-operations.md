# Topology and multi-key operations

Cluster topology can change while the service is running. Let the pinned
`valkey-go` client handle supported redirections and topology refresh, and
verify its actual behavior rather than copying standalone-client assumptions.

## Redirections and retries

- `MOVED` indicates that the slot has a new owner; the client should refresh
  topology according to its API and retry only when safe.
- `ASK` is a temporary migration redirection; follow the client-supported
  behavior without caching the temporary destination as permanent ownership.
- Bound retry count and total time with the request context.
- Never blindly retry a non-idempotent write after an ambiguous timeout.
- Include the command class and namespace in operational errors, not raw secret
  values or full payloads.

## Transactions and scripts

- All keys in a transaction or script must satisfy the cluster's slot rules.
- Use hash tags only to define an intentional atomic group.
- Verify behavior during slot migration, node loss, and topology refresh.
- Do not claim transaction atomicity across slots; redesign the operation using
  a single owner, an application workflow, or a durable source of truth.

Locks, cache invalidation, and idempotency remain application concerns. Cluster
routing does not remove the need for owner tokens, bounded leases, database
authority, or safe retry policy.
