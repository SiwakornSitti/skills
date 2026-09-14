---
name: golang-transactional-outbox
description: >
  Guides the implementation and usage of the Transactional Outbox pattern in Go for reliable,
  eventual-consistent asynchronous event publishing across bounded contexts and microservices.
license: MIT
compatibility: "Requires Go 1.22+ and PostgreSQL."
metadata:
  version: "1.0"
  tags: [messaging, event-driven, outbox, postgres, kafka, rabbitmq, ddd]
---

# Go Transactional Outbox

Read the matching topic reference when this skill applies:

- [overview-and-boundaries.md](references/overview-and-boundaries.md) — dual-write
  problem and outbox architecture.
- [schema-and-store.md](references/schema-and-store.md) — outbox schema and Go
  ports.
- [atomic-write.md](references/atomic-write.md) — saving business data and
  events in one Unit of Work.
- [relay.md](references/relay.md) — polling, publishing, delivery marking, and
  shutdown.
- [consumer-and-operations.md](references/consumer-and-operations.md) —
  idempotent consumers, retention, poison pills, and operational rules.

Completion check: the local write and outbox record share one transaction, the
relay remains restart-safe, consumers tolerate at-least-once delivery, and
operational failure paths are covered.

## Related skills

- [golang-concurrency](../golang-concurrency/SKILL.md)
- [golang-observability](../golang-observability/SKILL.md)
- [golang-unit-of-work](../golang-unit-of-work/SKILL.md)
- [golang-integration-testing](../golang-integration-testing/SKILL.md)
