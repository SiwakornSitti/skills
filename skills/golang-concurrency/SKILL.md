---
name: golang-concurrency
description: Design or change concurrent Go code in this service, including goroutines, channels, cancellation, worker limits, and race-safe tests.
license: MIT
compatibility: Requires Go 1.27+ and this repository's test suite.
metadata:
  version: "1.0"
  tags: [go, concurrency, goroutines, channels, context]
---

# Go Concurrency

Read the reference matching the concurrency concern:

- [when-and-ownership.md](references/when-and-ownership.md) — when concurrency is justified and who owns each goroutine.
- [cancellation-lifecycle.md](references/cancellation-lifecycle.md) — context cancellation and graceful completion.
- [channels.md](references/channels.md) — channel ownership, closure, and cancellation-safe sends.
- [bounded-concurrency.md](references/bounded-concurrency.md) — semaphores, worker pools, and bounded fan-out.
- [shared-state.md](references/shared-state.md) — mutexes, ownership, and race-safe state.
- [errors-and-coordination.md](references/errors-and-coordination.md) — first-error propagation and best-effort work.
- [verification.md](references/verification.md) — race, cancellation, completion, and failure-path tests.

Completion check: read every reference matching the change and apply its implementation and verification requirements.

## Related skills

- [golang-transactional-outbox](../golang-transactional-outbox/SKILL.md)
- [golang-unit-testing](../golang-unit-testing/SKILL.md)
- [golang-observability](../golang-observability/SKILL.md)
- [golang-redis](../golang-redis/SKILL.md)
