---
name: golang-apperror-logging
description: >
  Enforces the Log-Once pattern and structured error handling across hexagonal layers
  and cross-service boundaries using slog and pkg/apperror.
license: MIT
compatibility: "Requires Go 1.22+ and slog/apperror."
metadata:
  version: "1.0"
  tags: [logging, error-handling, slog, apperror, observability, opentelemetry]
---

# Go apperror-logging

Read the topic reference that matches the task:

- [log-once](references/log-once.md)
- [in-process errors](references/in-process-errors.md)
- [distributed errors](references/distributed-errors.md)
- [distributed tracing](references/distributed-tracing.md)
- [anti-patterns](references/anti-patterns.md)

Completion check: read every reference matching the change and apply its implementation and verification requirements.

## Related skills

- [golang-error-handling](../golang-error-handling/SKILL.md)
- [golang-observability](../golang-observability/SKILL.md)
- [golang-rest-api-design](../golang-rest-api-design/SKILL.md)
