# Concurrency and shutdown

- Use bounded concurrency and preserve ordering only within a partition or
  business key when the contract requires it.
- Stop accepting new messages on cancellation, finish bounded in-flight work
  within a deadline, and nack or release unfinished work for redelivery.
- Retry and DLQ processing must remain within the configured concurrency bound.
