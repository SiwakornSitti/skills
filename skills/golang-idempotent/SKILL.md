---
name: golang-idempotent
description: Design and implement idempotent Go operations safely across HTTP handlers, retries, workers, and persistent side effects.
license: MIT
metadata:
  tags: [golang, idempotency, retries, distributed-systems]
---

# Go idempotency

Read the reference matching the idempotency concern:

- [contract-and-scope.md](references/contract-and-scope.md) — headers, scope, retention, and replay contracts.
- [key-validation.md](references/key-validation.md) — key format, bounds, caller scope, and safe metadata.
- [fingerprints-and-conflicts.md](references/fingerprints-and-conflicts.md) — request binding and mismatch handling.
- [atomic-claims.md](references/atomic-claims.md) — pre-side-effect claims and in-progress state.
- [execution-and-storage.md](references/execution-and-storage.md) — business-write and record atomicity.
- [replay-and-failures.md](references/replay-and-failures.md) — completed responses, retries, and store failures.
- [retention-and-security.md](references/retention-and-security.md) — expiry, redaction, and sensitive response data.
- [verification.md](references/verification.md) — duplicate, concurrency, and recovery tests.

Completion check: read every reference matching the change and apply its implementation and verification requirements.

## Related skills

- [golang-rest-api-design](../golang-rest-api-design/SKILL.md)
- [golang-sql](../golang-sql/SKILL.md)
- [golang-unit-of-work](../golang-unit-of-work/SKILL.md)
- [software-principles](../software-principles/SKILL.md)
