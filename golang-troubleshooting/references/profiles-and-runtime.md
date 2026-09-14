# Profiles and runtime evidence

- Escalate tools gradually: focused tests and logs first, then goroutine, CPU, heap, block, mutex, or execution profiles.
- Use `net/http/pprof` only on protected diagnostic endpoints and bound collection duration.
- Use `go tool pprof`, `go tool trace`, and `GODEBUG` settings to test a hypothesis, not to collect noise.
- Use Delve only when source-level state is necessary; keep it optional and never expose a debugger in production.
- Hand confirmed bottlenecks to [golang-performance](../../golang-performance/SKILL.md).
