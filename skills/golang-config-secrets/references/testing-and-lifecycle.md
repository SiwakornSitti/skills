# Testing and lifecycle

- Test missing, malformed, defaulted, overridden, unknown, and redacted
  values without using real credentials.
- Verify environment precedence and JSON overlay behavior with table-driven
  tests.
- Test that invalid configuration fails before a client is constructed.
- Keep reload behavior out of the design unless it has explicit synchronization,
  partial-update, cancellation, and rollback tests.
