# Pub/sub verification

Unit-test decoding, validation, handler idempotency, cancellation, and
reconnect decisions without requiring Valkey. Use a real Valkey integration
test for transport behavior.

## Required integration cases

- Publisher and subscriber use the exact pinned `valkey-go` and Valkey versions.
- A subscribed consumer receives a valid message on the expected channel.
- Messages published before subscription are not treated as replayable history.
- Cancellation stops the receive loop and allows graceful shutdown.
- A disconnected subscriber follows the documented reconnect and resubscribe
  behavior.
- Messages published during a gap are either accepted as loss or recovered from
  the declared source of truth.
- Malformed payloads follow the chosen failure policy.
- Slow handlers obey the configured concurrency and overflow limits.

Do not use a Redis-only test as proof of Valkey pub/sub compatibility. Avoid
timing-only assertions where a readiness or synchronization signal can make
the test deterministic.
