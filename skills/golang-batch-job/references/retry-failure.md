# Retry and failure

- Use per-item timeouts, classify transient and permanent failures, and apply
  exponential backoff with jitter and bounded attempts.
- Do not retry invalid input or canceled work blindly. Make retry exhaustion a
  durable outcome.
- Send poisoned items to a durable dead-letter store with enough bounded
  metadata for operator inspection and replay.
- Define whether one failed item stops the batch or allows independent items to
  continue. Preserve successful item results during partial failure.
- Batch jobs own per-item retry and poison-item policy. `golang-consumer` owns
  broker acknowledgement, redelivery, and consumer dead-letter semantics.
