---
name: golang-hexagonal-architecture
description: >
  Guides Go developers in implementing and maintaining Hexagonal Architecture (Ports & Adapters)
  with Bounded Contexts, UseCase orchestration, domain isolation, and modular wiring.
  Use when creating a bounded context, wiring adapters, refactoring service layers, or fixing boundary lint violations.
license: MIT
compatibility: "Requires Go 1.27+ and this repository's Hexagonal project layout."
metadata:
  version: "1.1"
  tags: [architecture, hexagonal, ports-and-adapters, ddd, bounded-contexts]
---

# Go Hexagonal Architecture (Ports & Adapters)

This skill guides the design, implementation, and verification of clean hexagonal architecture across this repository's bounded contexts.

## Architecture References

Read the reference matching your specific architecture concern:

- [boundaries.md](references/boundaries.md) — Bounded contexts, dependency direction, and domain isolation.
- [layers.md](references/layers.md) — Roles of `domain/`, `service/`, `usecase/`, and `inbound/`/`outbound/` adapters.
- [wiring.md](references/wiring.md) — Composition roots (`module.go` and `cmd/server/main.go`) and dependency injection.
- [cross-context.md](references/cross-context.md) — Cross-context orchestration, exported domain contracts, and outbox events.
- [anti-patterns.md](references/anti-patterns.md) — Common traps (ORM leakage, protocol types in domain, cross-context transactions).
- [verification.md](references/verification.md) — Architectural checklists and automated verification commands.

## Reference Examples & Verification Scripts

- **Reference Implementation**: [examples/minimal_module/](examples/minimal_module/) provides a complete, working bounded context template with domain entities, ports, service invariants, in-memory repository, HTTP handler, and module composition root.
- **Verification Script**: [scripts/verify_hexagonal.sh](scripts/verify_hexagonal.sh) automatically validates domain purity and cross-context isolation.

## Completion Checklist

Before finalizing any architectural change:
1. Verify that `domain/` packages import zero infrastructure, database drivers, or HTTP libraries.
2. Confirm concrete adapter constructors are invoked exclusively in `module.go` or `cmd/`.
3. Run the automated boundary checker:
   ```bash
   .agents/skills/golang-hexagonal-architecture/scripts/verify_hexagonal.sh
   ```

## Related Skills

- [golang-idioms](../golang-idioms/SKILL.md)
- [golang-error-handling](../golang-error-handling/SKILL.md)
- [golang-unit-of-work](../golang-unit-of-work/SKILL.md)
- [golang-transactional-outbox](../golang-transactional-outbox/SKILL.md)
