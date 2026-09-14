---
name: golang-unit-of-work
description: >
  Applies a database-agnostic Unit of Work in Go when one bounded-context operation must
  atomically write through multiple repositories.
license: MIT
compatibility: "Requires Go 1.22+."
metadata:
  version: "1.0"
  tags: [database, transaction, unit-of-work, hexagonal]
---

# Go Unit of Work

Use this skill when a service operation coordinates multiple local repository
writes, writes local business data with an outbox record, or changes a
transaction adapter. Read the matching topic reference before changing the
port, adapter, service boundary, coordination, or tests:

- [boundaries-and-ports.md](references/boundaries-and-ports.md) for scope,
  domain ports, and database adapters;
- [lifecycle-and-coordination.md](references/lifecycle-and-coordination.md) for
  service lifecycle, outbox, cross-context calls, cache, and retries;
- [verification.md](references/verification.md) for unit and integration tests.

Use a repository directly for a single-repository operation. The service layer
normally owns the Unit of Work lifecycle for local business operations. A
usecase may own it only when it coordinates multiple repositories within the
same bounded context and no service owns that transaction. Keep each Unit of
Work inside one bounded context and database; cross-context coordination uses
separate local transactions plus an outbox or workflow.

Completion check: the domain port hides database infrastructure, the service
owns the lifecycle, all local writes use transaction-bound accessors, commit
occurs once, and the focused unit plus real-database atomicity checks pass.

## Related skills

- [golang-transactional-outbox](../golang-transactional-outbox/SKILL.md)
- [golang-integration-testing](../golang-integration-testing/SKILL.md)
- [golang-error-handling](../golang-error-handling/SKILL.md)
