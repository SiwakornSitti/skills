---
name: golang-integration-testing
description: >
  Guides Go developers in writing robust integration tests for repositories and cache adapters
  using a hybrid approach: Testcontainers-go with fallback to local Docker database/redis URLs.
license: MIT
compatibility: "Requires Go 1.22+, PostgreSQL, Redis, and optionally Docker."
metadata:
  version: "1.0"
  tags: [testing, integration-testing, testcontainers, postgres, redis, pgx]
---

# Go integration-testing

Read the reference matching the integration concern:

- [scope-and-tags.md](references/scope-and-tags.md) — scope and build-tag isolation.
- [environment-and-containers.md](references/environment-and-containers.md) — local URLs, Testcontainers fallback, and dynamic ports.
- [testmain-lifecycle.md](references/testmain-lifecycle.md) — package setup, readiness, teardown, and bounded contexts.
- [migrations-and-schema.md](references/migrations-and-schema.md) — sorted migrations and real schema setup.
- [fixtures-and-isolation.md](references/fixtures-and-isolation.md) — unique fixtures, cleanup, and parallelism.
- [database-and-repositories.md](references/database-and-repositories.md) — repository and Unit of Work behavior.
- [cache-and-adapters.md](references/cache-and-adapters.md) — cache, outbox, and external-adapter fidelity.
- [verification.md](references/verification.md) — commands, failure coverage, and evidence.

Completion check: read every reference matching the change and apply its implementation and verification requirements.

## Related skills

- [golang-unit-testing](../golang-unit-testing/SKILL.md)
- [golang-postgres](../golang-postgres/SKILL.md)
- [golang-mysql](../golang-mysql/SKILL.md)
- [golang-redis](../golang-redis/SKILL.md)
