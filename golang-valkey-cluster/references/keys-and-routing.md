# Keys and routing

Cluster routing is determined by the key's hash slot. Key naming is therefore a
correctness concern, not only a naming convention.

## Key rules

- Build keys in one owned function or type.
- Include namespace and schema version, for example `account:v1:<id>`.
- Use a hash tag only when related keys must share a slot, for example
  `account:{123}:profile` and `account:{123}:limits`.
- Keep the tag stable, bounded, and based on the domain identity that defines
  the atomic boundary.
- Do not put secrets or unbounded user input directly into keys.

Hash tags improve co-location but can create hot slots when one identity is much
more active than others. Choose them for a concrete multi-key requirement, not
by default.

## Command rules

- Single-key commands are normally routable by the cluster-aware client.
- Multi-key commands require all keys to share a slot when the command supports
  cluster execution.
- A transaction or script that touches keys from different slots must be
  rejected or redesigned; do not assume the client can make it atomic.
- Commands without a key need an explicit cluster-safe policy and must be
  verified against the pinned client and server versions.
- Avoid broad scans and keyspace-wide operations in request paths; they do not
  behave like a cheap standalone-node command in a cluster.

Test key builders for stable namespaces, version changes, and intended shared
hash tags. Do not duplicate slot calculation in application code.
