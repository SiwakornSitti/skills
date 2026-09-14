---
name: golang-core-service
description: Build Go core services that own business capabilities, invariants, state transitions, and durable side effects behind explicit ports. Use when implementing or changing domain logic consumed by a BFF, another service, a worker, or an external API.
license: MIT
metadata:
  version: "1.0"
  tags: [go, core-service, domain, use-case, hexagonal, bounded-context]
---

# Go core service

A core service owns one bounded business capability. Its `service/` layer is the default application layer for operations within that context; do not add a `usecase/` wrapper by convention.

Add `usecase/` only when a workflow coordinates multiple bounded contexts or services. Calling multiple repositories, using a Unit of Work, or calling an outbound adapter within the same context remains `service/` logic. BFF composition belongs in the BFF, not in a core-service `usecase/` package.

Read the reference matching the change:

- [boundaries-and-domain.md](references/boundaries-and-domain.md) — define capability ownership, entities, invariants, and context boundaries.
- [use-cases-and-ports.md](references/use-cases-and-ports.md) — orchestrate business operations through narrow ports.
- [persistence-and-transactions.md](references/persistence-and-transactions.md) — protect state changes and side effects atomically.
- [api-and-events.md](references/api-and-events.md) — expose stable synchronous and asynchronous contracts.
- [errors-and-observability.md](references/errors-and-observability.md) — classify errors and emit useful boundary telemetry.
- [verification.md](references/verification.md) — verify invariants, adapters, contracts, and recovery behavior.

Use [golang-hexagonal-architecture](../golang-hexagonal-architecture/SKILL.md) for package boundaries, [golang-error-handling](../golang-error-handling/SKILL.md) for error contracts, and [golang-unit-of-work](../golang-unit-of-work/SKILL.md) when one operation spans multiple repositories.

Completion check: the core service is the authoritative owner of its business rules, authorization-relevant domain decisions, state transitions, persistence, and side effects. Clients and BFFs consume its contracts rather than reimplementing them.

## Related skills

- [golang-bff](../golang-bff/SKILL.md)
- [golang-consumer](../golang-consumer/SKILL.md)
- [golang-transactional-outbox](../golang-transactional-outbox/SKILL.md)
- [golang-observability](../golang-observability/SKILL.md)
- [golang-unit-testing](../golang-unit-testing/SKILL.md)
