# Errors and disclosure

- Return generic external errors while preserving safe internal context for
  logs and diagnostics.
- Exclude stack traces, SQL, credentials, tokens, raw request data, and other
  sensitive values from client responses and error metadata.
- Map security outcomes to the established boundary contract; do not invent a
  response shape while fixing a security issue.
