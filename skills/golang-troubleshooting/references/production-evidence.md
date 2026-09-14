# Production evidence

- Correlate logs, metrics, and traces with stable request or job identifiers and bounded dimensions.
- Capture versions, configuration shape, dependency health, resource limits, and deployment changes.
- Redact credentials, tokens, PII, and sensitive payloads while preserving the fields needed to diagnose the failure.
- Prefer reversible diagnostic controls and time-bounded sampling; do not add permanent verbose logging to hot paths.
- Use [golang-observability](../../golang-observability/SKILL.md) for instrumentation changes and [sensitive-data](../../sensitive-data/SKILL.md) for redaction rules.
