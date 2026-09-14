## Verification

Cover hit, miss, expiry, invalidation, cancellation, redis.Nil, timeout, and
client failure paths relevant to the change. Use a real Redis integration test
for serialization, TTL, atomicity, transactions, scripts, or concurrency. A
mock can verify adapter interaction but cannot prove Redis command semantics.
