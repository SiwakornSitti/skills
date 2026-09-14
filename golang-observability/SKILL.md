---
name: golang-observability
description: Add or change Go service logging, metrics, or OpenTelemetry traces while preserving useful correlation and bounded telemetry cardinality.
license: MIT
compatibility: Requires Go 1.27+ and this repository's slog and OpenTelemetry dependencies.
metadata:
  version: "1.0"
  tags: [go, observability, logging, metrics, tracing, opentelemetry]
---

# Go observability

Read the topic reference that matches the task:

- [logging.md](references/logging.md) — structured slog events and log levels.
- [tracing.md](references/tracing.md) — span boundaries, attributes, status, and W3C propagation.
- [metrics.md](references/metrics.md) — instruments, units, labels, and cardinality.
- [operations.md](references/operations.md) — boundaries, errors, lifecycle, privacy, cost, verification, and anti-patterns.

Completion check: read every reference matching the change and apply its implementation and verification requirements.

## Related skills

- [golang-apperror-logging](../golang-apperror-logging/SKILL.md) — log-once error boundaries.
- [golang-rest-api-design](../golang-rest-api-design/SKILL.md) — HTTP boundary instrumentation.
- [golang-concurrency](../golang-concurrency/SKILL.md) — cancellation and worker lifecycle.
- [golang-redis](../golang-redis/SKILL.md) and [golang-valkey](../golang-valkey/SKILL.md) — cache and client telemetry.
