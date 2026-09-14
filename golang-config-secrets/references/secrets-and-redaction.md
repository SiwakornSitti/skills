# Secrets and redaction

- Keep secret values out of logs, errors, metrics, URLs, command lines,
  fixtures, and Docker build arguments.
- Treat JSON objects containing secrets as sensitive. Prefer a secret manager
  or dedicated environment values.
- Never log, commit, return, or serialize a raw secret-bearing object. Redact
  sensitive fields in diagnostics.
- Keep classification, rotation, and deployment-specific protection in
  `sensitive-data`, `golang-security`, and `golang-docker`.
