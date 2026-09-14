---
name: golang-swagger
description: Document Go HTTP handlers with this service's swaggo annotations and regenerate the checked-in Swagger specification.
license: MIT
compatibility: Requires swaggo/swag and the repository Makefile.
metadata:
  version: "1.0"
  tags: [go, swagger, openapi, swaggo, api]
---

# Go Swagger

Read the matching topic reference before changing a handler contract:

- [annotations-and-models.md](references/annotations-and-models.md) — comment
  directives, request DTOs, response DTOs, and schema examples.
- [routes-and-contracts.md](references/routes-and-contracts.md) — Gorilla Mux
  routes, parameters, pagination, errors, and status codes.
- [generation-and-artifacts.md](references/generation-and-artifacts.md) — Swaggo
  commands, tool versions, generated files, and ownership.
- [verification.md](references/verification.md) — route parity, tests, spec
  inspection, and troubleshooting.

Completion check: the annotations match the registered route and runtime wire
contract, generated artifacts are regenerated rather than hand-edited, and
focused verification passes.

## Related skills

- [golang-rest-api-design](../golang-rest-api-design/SKILL.md)
- [golang-unit-testing](../golang-unit-testing/SKILL.md)
- [golang-observability](../golang-observability/SKILL.md)
