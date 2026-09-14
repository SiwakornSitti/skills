## Verification

Run focused tests for missing values, expiry, timeout, cancellation, retry
behavior, and invalidation. Use a real Valkey integration test for command
semantics, serialization, TTL, transactions, scripts, streams, pub/sub, locks,
or concurrency. Test the exact pinned client and server versions; a Redis test
alone is not proof of Valkey compatibility.
