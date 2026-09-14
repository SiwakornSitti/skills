# Cancellation and lifecycle

- Give every goroutine a `context.Context` lifecycle. Return or select on
  `ctx.Done()` for blocking work.
- Stop accepting new work after cancellation and wait for owned goroutines
  before the owner returns.
- Preserve the distinction between caller cancellation and an operational
  error that caused sibling cancellation.
- Ensure cancellation while producing and cancellation while processing both
  leave the system able to complete or release its work.
