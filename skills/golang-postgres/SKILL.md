---
name: golang-postgres
description: Change PostgreSQL access in this Go service using pgx, transactions, row mapping, and query verification.
license: MIT
compatibility: Requires this repository's pgx and PostgreSQL packages.
metadata:
  version: "1.0"
  tags: [go, postgres, pgx, database, persistence]
---

# Go PostgreSQL

Read the topic reference that matches the task:

- [queries-and-mapping.md](references/queries-and-mapping.md) — contexts, SQL parameters, row mapping, errors, and pool lifecycle.
- [query-optimization.md](references/query-optimization.md) — PostgreSQL query plans, indexes, batching, and pagination choices.
- [transactions-and-uow.md](references/transactions-and-uow.md) — transaction ownership, Unit of Work, and retry boundaries.
- [pagination.md](references/pagination.md) — deterministic ordering and pagination contracts.
- [verification.md](references/verification.md) — integration tests, commands, and database observability.

Completion check: read every reference matching the change and apply its implementation and verification requirements.

## Related skills

- [golang-sql](../golang-sql/SKILL.md)
- [golang-integration-testing](../golang-integration-testing/SKILL.md)
- [golang-migrations](../golang-migrations/SKILL.md)
- [golang-unit-of-work](../golang-unit-of-work/SKILL.md)
