# Boundaries

**Bounded Context**: an independently owned business model and transaction boundary. In this repository, each `internal/<context>` directory is one bounded context.

- The domain is the core: it owns entities, business rules, ports, and expected domain errors.
- Dependencies point inward. Domain packages do not import adapters, database drivers, HTTP types, loggers, or infrastructure packages.
- A consuming `usecase/` owns a narrow port for each cross-context capability it needs.
- A boundary adapter may use the target context’s exported domain contract, translate its values into caller-owned DTOs, and live under `outbound/<dependency>/`.
- Cross-context code never imports another context’s `repository`, `service`, or `handler` implementation; usecases do not depend on foreign domain entities.
- Keep context-specific vocabulary and invariants inside the owning context; share stable identifiers or events only when the relationship requires it.
