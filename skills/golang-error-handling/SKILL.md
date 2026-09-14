---
name: golang-error-handling
description: Design or change Go error values, wrapping, matching, and boundary translation in this hexagonal service.
license: MIT
compatibility: Requires Go 1.27+ and the repository's HTTP error helpers.
metadata:
  version: "1.0"
  tags: [go, errors, error-handling, hexagonal]
---

# Go Error Handling

Read the topic reference that matches the task:

- [domain-errors.md](references/domain-errors.md) — domain sentinels and expected business outcomes.
- [wrapping-and-matching.md](references/wrapping-and-matching.md) — error chains, wrapping, and typed matching.
- [boundary-translation.md](references/boundary-translation.md) — adapter, HTTP, and message-boundary translation.
- [verification.md](references/verification.md) — error-chain and boundary-contract tests.

Completion check: read every reference matching the change and apply its implementation and verification requirements.

## Related skills

- [golang-apperror-logging](../golang-apperror-logging/SKILL.md)
- [golang-rest-api-design](../golang-rest-api-design/SKILL.md)
- [golang-unit-testing](../golang-unit-testing/SKILL.md)
