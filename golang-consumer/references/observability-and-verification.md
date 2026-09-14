# Observability and verification

- Emit bounded structured telemetry for message type, source, duration,
  success, retry, dead-letter, lag, and in-flight work. Do not log payloads,
  secrets, or raw personal data.
- Test acknowledgement behavior, duplicate delivery, concurrent processing,
  cancellation, retry count/backoff/release, durable DLQ forwarding before
  acknowledgement, malformed payloads, and schema versions.
