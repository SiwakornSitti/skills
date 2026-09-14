# Value and pointer semantics

- **Pointer receivers (`*T`)**: Use for stateful structs (`service`, `repository`, `Handler`, `Relay`) or structs containing mutexes/pools (`*pgxpool.Pool`).
- **Value semantics (`T`)**: Use for immutable command/query structs (`domain.CreateCommand`, `domain.ListQuery`).
