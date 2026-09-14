---
name: golang-rest-api-design
description: Design or change REST endpoints in this Go hexagonal service, including Gorilla Mux routes, HTTP handlers, response contracts, pagination, errors, and Swagger annotations.
license: MIT
compatibility: Requires the repository's Go HTTP server packages and Gorilla Mux handlers.
metadata:
  version: "1.1"
  tags: [go, rest, http, api, swagger, gorilla-mux]
---

# Go REST API design

Read the reference that matches the change:

- [routes.md](references/routes.md) — resource paths, methods, nesting, and route compatibility.
- [boundaries.md](references/boundaries.md) — handler ownership, identity, layering, and context.
- [requests.md](references/requests.md) — DTOs, decoding, validation, and normalization.
- [responses.md](references/responses.md) — response DTOs, status codes, headers, and bodies.
- [idempotency.md](references/idempotency.md) — retriable commands, replay, and cancellation.
- [errors.md](references/errors.md) — error mapping, safe messages, and boundary translation.
- [pagination.md](references/pagination.md) — filters, limits, ordering, and pagination contracts.
- [contract-first.md](references/contract-first.md) — public contract discovery and compatibility decisions.
- [swagger.md](references/swagger.md) — annotation parity and generated documentation ownership.
- [verification.md](references/verification.md) — router tests and focused verification.

Completion check: read every reference matching the change and apply its route, contract, and verification requirements.

## Related skills

- [golang-swagger](../golang-swagger/SKILL.md) — generated Swagger documentation.
- [golang-error-handling](../golang-error-handling/SKILL.md) — error wrapping and boundary translation.
- [golang-apperror-logging](../golang-apperror-logging/SKILL.md) — log-once HTTP failures.
- [golang-observability](../golang-observability/SKILL.md) — request logs, metrics, and traces.
- [golang-unit-testing](../golang-unit-testing/SKILL.md) — focused handler tests.
