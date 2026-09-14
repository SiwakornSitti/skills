# Redaction and Telemetry

- Redact sensitive fields before logs, errors, metrics, traces, fixtures, and diagnostics. Prefer allowlisted telemetry over denylist redaction.
- Keep raw requests, responses, config objects, tokens, and credentials out of logs and error metadata.
- Test with obvious placeholders and assert sensitive values are absent from responses, logs, errors, and metrics.

## Applied principles

- Data minimization: emit only fields needed to operate or diagnose the event.
- Least privilege: give each logger, exporter, and support workflow access only to the fields it needs.
- Fail closed: if a field is not classified, exclude it from telemetry until explicitly approved.
- Separation of concerns: business code emits structured facts; redaction and export policy protect the boundary.
- Defense in depth: combine safe event design, redaction, access control, retention, and tests; do not rely on one filter.

Example: allowlist an opaque ID and outcome, then omit the request object entirely:

Safe diagnostic output keeps only what the event needs:

```json
{"event":"customer.lookup","result":"found"}
```

Bad error:

```text
customer lookup failed for email=user@example.invalid phone=+66000000000
```

Safe error:

```text
customer lookup failed
```
