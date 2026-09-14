# Concurrency and backpressure

- Bound worker concurrency, batch size, connection-pool usage, queue
  buffering, and downstream rate limits together.
- Use backpressure to prevent an input surge from exhausting memory, database
  connections, or downstream capacity.
- Keep detailed goroutine, channel, and cancellation patterns in
  `golang-concurrency`; this skill defines the batch-level limits and ownership.
