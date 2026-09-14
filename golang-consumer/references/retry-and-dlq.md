# Retry and DLQ

- Classify failures with typed or sentinel errors via `errors.Is`/`errors.As`,
  never error text.
- Retry transient failures with broker-native redelivery, nack/release,
  visibility, or lease handling.
- Dead-letter malformed or poison messages immediately, and repeatedly failing
  transient messages after a configurable maximum attempt count. Confirm
  durable DLQ handoff before acknowledging the original message.
- Configure retry count, backoff, visibility or lease timeouts, queue names,
  and concurrency outside the binary.
- Preserve safe DLQ metadata such as message ID, type, schema version, source,
  attempt count, timestamps, and failure reason; omit secrets and raw personal
  data.
- Replay DLQ messages only through an explicit operator action after the cause
  is fixed.
