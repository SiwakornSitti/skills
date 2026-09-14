# Cluster verification

Unit-test key builders, slot-sharing decisions, retry classification, and
context cancellation without depending on a cluster. Use a real multi-node
Valkey Cluster for routing and topology behavior.

## Required integration cases

- The exact pinned `valkey-go` and Valkey server versions are used.
- Single-key reads and writes route successfully to the owning node.
- Related hash-tagged keys support the intended multi-key operation.
- Keys without a shared slot fail according to the declared contract; they are
  not silently treated as atomic.
- Transactions and scripts obey same-slot restrictions.
- `MOVED` and `ASK` responses are handled according to the client contract.
- Topology refresh succeeds after slot movement or node change.
- Timeouts and cancellation stop waiting and do not create unbounded retries.
- Node loss or partial availability follows the service's fail-open or
  fail-closed policy.

Do not use a standalone Valkey or Redis test as proof of cluster compatibility.
Do not assert only that a command eventually succeeds; verify the routing,
retry, and atomicity behavior that makes the operation safe.
