---
name: golang-safety
description: Prevent accidental Go panics, silent data corruption, and unsafe zero-value assumptions. Use when reviewing nil handling, type assertions, slice or map ownership, numeric conversions, resource lifecycles, or defensive copies.
license: MIT
compatibility: "Requires Go 1.22+."
metadata:
  version: "1.0"
  tags: [go, safety, nil, slices, maps, correctness]
---

# Go safety

Read the reference matching the safety concern:

- [nil-and-interfaces.md](references/nil-and-interfaces.md) — nil values, interfaces, maps, channels, and type assertions.
- [slices-and-maps.md](references/slices-and-maps.md) — aliasing, ownership, mutation, and defensive copies.
- [numbers-and-resources.md](references/numbers-and-resources.md) — numeric boundaries, float comparison, division, and cleanup.
- [zero-values-and-init.md](references/zero-values-and-init.md) — usable zero values, lazy initialization, and explicit setup.
- [verification.md](references/verification.md) — tests and static checks for safety assumptions.

Keep concurrent access in [golang-concurrency](../golang-concurrency/SKILL.md), exploitable weaknesses in [golang-security](../golang-security/SKILL.md), and active failures in [golang-troubleshooting](../golang-troubleshooting/SKILL.md).

Completion check: read every reference matching the change and verify the safety assumption that could otherwise panic or corrupt data.

## Related skills

- [golang-idioms](../golang-idioms/SKILL.md)
- [golang-concurrency](../golang-concurrency/SKILL.md)
- [golang-security](../golang-security/SKILL.md)
- [golang-unit-testing](../golang-unit-testing/SKILL.md)
