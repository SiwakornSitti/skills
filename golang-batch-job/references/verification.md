# Verification

- Test duplicate delivery, concurrent claims, restart, timeout, retry
  exhaustion, lease expiry, cancellation, and partial failure.
- Verify that progress and the item result remain consistent after worker
  failure and recovery.
- Use an integration test for the real queue, partition, or lease store when
  coordination behavior cannot be proven with a fake.
- Exercise representative batch sizes and downstream limits before claiming a
  throughput or lag target.
