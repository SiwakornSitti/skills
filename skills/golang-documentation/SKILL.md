---
name: golang-documentation
description: Write and verify useful Go package documentation, exported API comments, examples, READMEs, and operational guidance. Use when adding public APIs, documenting behavior, updating examples, or checking generated references.
license: MIT
compatibility: "Requires Go 1.22+."
metadata:
  version: "1.0"
  tags: [go, documentation, godoc, examples, readme, api]
---

# Go documentation

Read the reference matching the documentation concern:

- [package-and-api.md](references/package-and-api.md) — package comments, exported declarations, and behavioral contracts.
- [examples-and-readmes.md](references/examples-and-readmes.md) — runnable examples, setup, and usage documentation.
- [generated-contracts.md](references/generated-contracts.md) — generated API references and ownership boundaries.
- [verification.md](references/verification.md) — documentation checks and example execution.

Keep HTTP/OpenAPI contract ownership in [golang-rest-api-design](../golang-rest-api-design/SKILL.md) and [golang-swagger](../golang-swagger/SKILL.md); keep sensitive examples safe through [sensitive-data](../sensitive-data/SKILL.md).

Completion check: document the behavior a caller must rely on, keep examples runnable, and verify generated output through its source workflow.

## Related skills

- [golang-idioms](../golang-idioms/SKILL.md)
- [golang-rest-api-design](../golang-rest-api-design/SKILL.md)
- [golang-swagger](../golang-swagger/SKILL.md)
- [sensitive-data](../sensitive-data/SKILL.md)
