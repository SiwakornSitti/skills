---
name: golang-sql
description: Change relational database access in Go with driver-agnostic SQL, context, transactions, row mapping, and query verification.
license: MIT
compatibility: Requires Go's database/sql package and the repository's chosen driver.
metadata:
  version: "1.0"
  tags: [go, sql, database, persistence]
---

# Go SQL

Read the reference matching the SQL concern:

- [boundaries-and-mapping.md](references/boundaries-and-mapping.md) — adapter ownership and domain mapping.
- [context-and-queries.md](references/context-and-queries.md) — context, parameters, columns, and row iteration.
- [writes-and-rows.md](references/writes-and-rows.md) — writes, affected rows, and command outcomes.
- [transactions-and-uow.md](references/transactions-and-uow.md) — transaction scope and Unit of Work.
- [nullability-and-errors.md](references/nullability-and-errors.md) — nullable values and repository errors.
- [pagination-and-cursors.md](references/pagination-and-cursors.md) — keyset pagination and cursor safety.
- [query-optimization.md](references/query-optimization.md) — indexes, plans, and N+1 avoidance.
- [verification.md](references/verification.md) — actual-engine integration tests and package checks.

Completion check: read every reference matching the change and apply its implementation and verification requirements.

## Related skills

- [golang-postgres](../golang-postgres/SKILL.md)
- [golang-mysql](../golang-mysql/SKILL.md)
- [golang-integration-testing](../golang-integration-testing/SKILL.md)
- [golang-unit-of-work](../golang-unit-of-work/SKILL.md)
