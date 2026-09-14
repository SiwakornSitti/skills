---
name: golang-bff
description: Compose client-specific Go APIs from core-service contracts while preserving domain ownership, bounded latency, safe data shaping, and explicit partial-failure behavior. Use when building or changing a Backend-for-Frontend, aggregating core services, or designing client-specific API orchestration.
license: MIT
metadata:
  version: "1.0"
  tags: [go, bff, api-composition, orchestration, aggregation, hexagonal]
---

# Go BFF

Read the reference matching the change:

- [boundary-and-ownership.md](references/boundary-and-ownership.md) — decide what belongs in the BFF versus a core service.
- [composition-and-orchestration.md](references/composition-and-orchestration.md) — compose independent reads and sequence dependent calls.
- [core-service-clients.md](references/core-service-clients.md) — isolate outbound clients behind ports and preserve upstream contracts.
- [contracts-and-data-shaping.md](references/contracts-and-data-shaping.md) — define client DTOs, field allowlists, and compatibility rules.
- [resilience-and-partial-failure.md](references/resilience-and-partial-failure.md) — apply request budgets, safe retries, cancellation, and failure policy.
- [auth-privacy-and-caching.md](references/auth-privacy-and-caching.md) — propagate trusted identity, minimize data, and cache safely.
- [verification.md](references/verification.md) — test orchestration, contracts, failure modes, and forbidden coupling.

Use [golang-rest-api-design](../golang-rest-api-design/SKILL.md) for the inbound HTTP contract, [golang-error-handling](../golang-error-handling/SKILL.md) for error translation, and [golang-observability](../golang-observability/SKILL.md) for telemetry.

Completion check: the BFF owns presentation composition only; core services own business rules, state transitions, persistence, and canonical domain errors. Verify required and optional upstream failures explicitly.

## Related skills

- [golang-hexagonal-architecture](../golang-hexagonal-architecture/SKILL.md)
- [golang-idempotent](../golang-idempotent/SKILL.md)
- [sensitive-data](../sensitive-data/SKILL.md)
- [software-principles](../software-principles/SKILL.md)
