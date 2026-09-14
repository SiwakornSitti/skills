# Concurrency failures

- For hangs, inspect goroutine stacks and channel ownership; for races, reproduce under `go test -race`.
- Check every goroutine for a cancellation path, completion signal, and owned resource cleanup.
- Inspect mutex and block profiles when contention or starvation is suspected.
- Keep the design fix in [golang-concurrency](../../golang-concurrency/SKILL.md); this reference supplies the diagnostic path.
- Avoid increasing timeouts or adding sleeps as a substitute for identifying the blocked owner.
