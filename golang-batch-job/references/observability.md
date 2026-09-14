# Observability

- Emit structured counters and logs for processed, succeeded, failed,
  retried, delayed, and dead-lettered items.
- Record bounded operation, worker, partition, outcome, and retry metadata.
  Never use raw payloads or unbounded item identifiers as metric labels.
- Use traces for a batch or item journey when they answer an operational
  question; keep signal ownership and correlation in `golang-observability`.
