# Zero values and initialization

- Prefer types whose zero value is immediately useful and safe.
- Lazy-initialize mutable fields at the owning method when zero-value construction is a supported contract.
- Use explicit constructors for required dependencies and invariants; keep package initialization free of hidden ordering requirements.
- Use `sync.Once` only for genuinely shared lazy initialization and follow [golang-concurrency](../../golang-concurrency/SKILL.md) for its lifecycle.
- Document required initialization when a useful zero value is impossible.
