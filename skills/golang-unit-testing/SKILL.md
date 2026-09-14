---
name: golang-unit-testing
description: >
  Guides Go developers in writing isolated, high-performance unit tests in Hexagonal Architecture
  using Go's standard testing tools, test doubles, and table-driven structures.
license: MIT
compatibility: "Requires Go 1.22+."
metadata:
  version: "1.1"
  tags: [go, testing, unit-testing, test-doubles, table-driven, hexagonal]
---

# Go unit-testing

Read only the topic references matching the change:

- [principles-and-boundaries.md](references/principles-and-boundaries.md) — unit scope, layering, placement, observable behavior, and test naming.
- [doubles-and-mocks.md](references/doubles-and-mocks.md) — fakes, stubs, mocks, and Mockery lifecycle.
- [service-usecase-consumer.md](references/service-usecase-consumer.md) — domain, service, transaction, use-case, and consumer tests.
- [http-handlers.md](references/http-handlers.md) — Gorilla Mux handler tests with `httptest`.
- [determinism-and-concurrency.md](references/determinism-and-concurrency.md) — table cases, context, time, goroutines, fuzzing, and benchmarks.
- [commands-and-antipatterns.md](references/commands-and-antipatterns.md) — test commands and failure patterns.

Completion check: read every reference matching the change and apply its implementation and verification requirements.

## Related skills

- [golang-mockery](../golang-mockery/SKILL.md)
- [golang-integration-testing](../golang-integration-testing/SKILL.md)
- [golang-error-handling](../golang-error-handling/SKILL.md)
- [golang-concurrency](../golang-concurrency/SKILL.md)
