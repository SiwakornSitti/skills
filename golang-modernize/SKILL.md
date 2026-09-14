---
name: golang-modernize
description: Modernize Go code or dependencies in this service with small, compatible upgrades; use for Go-version upgrades, legacy-idiom cleanup, or dependency refreshes.
license: MIT
compatibility: Requires this repository's Go modules and test suite.
metadata:
  version: "1.0"
  tags: [go, modernization, dependencies, refactoring]
---

# Modernize Go

Read the matching reference before changing Go code:

- [version-and-stdlib.md](references/version-and-stdlib.md) — Go version ceilings and standard-library migrations.
- [dependencies.md](references/dependencies.md) — dependency upgrades, release notes, and module graph changes.
- [source-modernization.md](references/source-modernization.md) — legacy idioms, `go fix`, and compatibility boundaries.
- [verification.md](references/verification.md) — formatting, tests, vetting, and diff review.

Completion check: read every reference matching the change and apply its implementation and verification requirements.

## Related skills

- [golang-idioms](../golang-idioms/SKILL.md)
- [golang-docker](../golang-docker/SKILL.md)
- [golang-security](../golang-security/SKILL.md)
