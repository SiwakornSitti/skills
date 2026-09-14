# Cache verification

Cover hit, miss, expiry, invalidation, cancellation, backend timeout, and
client failure paths relevant to the change. Assert that a source-system read
occurs on a miss and is avoided on a valid hit.

For cache-aside request coalescing, test concurrent same-key misses and assert
that the source is read once. If the double-check path is used, also verify
that a cache value found inside the group avoids the source read.

Use a real cache-backend integration test for serialization, TTL, atomicity,
transactions, scripts, concurrency, or backend-specific missing-value behavior.
A mock can verify adapter interaction but cannot prove cache command semantics.

Observe latency, hit ratio, miss ratio, evictions, serialization failures, and
backend errors. Distinguish local adapter behavior from live backend delivery;
do not claim production cache health from unit tests alone.

Related skills:

- [golang-integration-testing](../../golang-integration-testing/SKILL.md)
- [golang-observability](../../golang-observability/SKILL.md)
