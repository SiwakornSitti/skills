---
name: golang-batch-job
description: Design and implement scalable Go batch jobs with durable work coordination, idempotent processing, bounded concurrency, backpressure, retries, and safe restarts.
license: MIT
metadata:
  tags: [golang, batch, workers, scalability]
---

# Go batch jobs

Read the reference matching the batch-job concern:

- [workload-contract.md](references/workload-contract.md) — item boundaries, throughput, lag, and ordering.
- [durable-coordination.md](references/durable-coordination.md) — durable claims, progress, leases, and recovery.
- [processing-idempotency.md](references/processing-idempotency.md) — stateless and duplicate-safe item processing.
- [concurrency-backpressure.md](references/concurrency-backpressure.md) — worker bounds and dependency protection.
- [retry-failure.md](references/retry-failure.md) — timeouts, retries, poison items, and partial failure.
- [lifecycle-restarts.md](references/lifecycle-restarts.md) — cancellation, shutdown, lease expiry, and restart safety.
- [observability.md](references/observability.md) — batch outcomes, logs, metrics, and bounded metadata.
- [verification.md](references/verification.md) — failure-mode tests and workload checks.

Completion check: read every reference matching the change and apply its implementation and verification requirements.

## Related skills

- [golang-idempotent](../golang-idempotent/SKILL.md)
- [golang-concurrency](../golang-concurrency/SKILL.md)
- [golang-observability](../golang-observability/SKILL.md)
- [golang-sql](../golang-sql/SKILL.md)
- [software-principles](../software-principles/SKILL.md)
