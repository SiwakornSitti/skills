# When and ownership

Use concurrency only when it improves latency, throughput, or cancellation.
Trace who starts, stops, and observes every goroutine before changing it.

- Give every goroutine one clear owner responsible for its lifecycle and
  completion.
- Use the smallest pattern that satisfies the workload. Prefer
  semaphore-limited goroutines; use a worker pool when queueing, worker reuse,
  or explicit backpressure is needed.
