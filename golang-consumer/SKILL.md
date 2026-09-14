---
name: golang-consumer
description: Design and implement Go message consumers with at-least-once delivery, idempotent handlers, bounded concurrency, retries, dead-letter handling, and graceful shutdown.
license: MIT
metadata:
  tags: [golang, consumer, messaging, reliability]
---

# Go consumers

Read the topic reference that matches the task:

- [boundaries-and-delivery.md](references/boundaries-and-delivery.md) — broker boundaries, validation, acknowledgement, and idempotency.
- [retry-and-dlq.md](references/retry-and-dlq.md) — error classification, retries, dead-lettering, and replay.
- [concurrency-and-shutdown.md](references/concurrency-and-shutdown.md) — bounded work, ordering, cancellation, and shutdown.
- [observability-and-verification.md](references/observability-and-verification.md) — telemetry, privacy, and required tests.

Completion check: read every reference matching the change and apply its implementation and verification requirements.

## Related skills

- [golang-idempotent](../golang-idempotent/SKILL.md)
- [golang-error-handling](../golang-error-handling/SKILL.md)
- [golang-concurrency](../golang-concurrency/SKILL.md)
- [golang-observability](../golang-observability/SKILL.md)
- [golang-transactional-outbox](../golang-transactional-outbox/SKILL.md)
