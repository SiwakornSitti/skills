# Boundaries and domain ownership

Treat one `internal/<context>` module as the owner of a cohesive business capability. Keep its entities, value objects, invariants, domain errors, and ports inside that context. Other contexts depend on exported contracts, not private implementation details.

The core service owns decisions that must remain true regardless of caller: valid state transitions, ownership checks, monetary rules, uniqueness, lifecycle rules, and side-effect preconditions. A BFF may select a client view, but it must not decide these rules.

Keep domain code independent of HTTP, gRPC, brokers, SQL, caches, generated models, and framework lifecycle. Put adapters under inbound or outbound boundaries and map their models at the edge.

Do not create a “shared domain” package to avoid deciding ownership. Share stable primitives only when they have no business ownership; otherwise keep the rule in the owning context and expose a port or contract.
