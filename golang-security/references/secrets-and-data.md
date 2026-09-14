# Secrets and sensitive data

- Keep secrets out of source, logs, tests, Docker layers, images, command
  lines, URLs, and error metadata. Redact before recording values.
- Use safe placeholders in examples and fixtures; never commit real
  credentials.
- Keep classification, minimization, retention, and redaction details in
  `sensitive-data`. Keep loading and precedence in
  `golang-config-secrets`.
