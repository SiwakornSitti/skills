# Retention and security

- Make retention explicit and bounded, and keep it long enough to cover the
  client retry window. Treat an expired key as a new request.
- Avoid storing sensitive response data unless the contract requires replay;
  encrypt or protect it through the owning storage boundary when necessary.
- Redact secrets, credentials, tokens, raw keys, and sensitive response data
  from logs, metrics, traces, and diagnostics.
- Keep authentication, secret protection, and PII classification in the
  owning security and sensitive-data skills.
