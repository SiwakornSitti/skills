# Boundaries and delivery

Treat message delivery as at-least-once and acknowledge only completed
business processing.

- Keep broker code in `inbound/consumer/`; pass validated domain
  commands or events to the use case, never broker types.
- Validate the message envelope, schema version, required fields, and
  authorization context at the boundary. Reject malformed messages safely.
- Make handlers idempotent. Duplicate delivery must not repeat business side
  effects.
- Acknowledge only after successful processing and durable completion. Never
  silently acknowledge an error.
