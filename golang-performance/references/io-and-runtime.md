# I/O and runtime

- Confirm whether latency is inside the process or waiting on a database, network, filesystem, or downstream service before changing Go code.
- Size HTTP and database pools to the measured concurrency and downstream limits; do not treat larger pools as automatically faster.
- Profile serialization and batching when I/O dominates; preserve cancellation and timeout behavior.
- Tune GC, `GOMAXPROCS`, or container memory limits only after runtime evidence identifies a problem.
- Keep tracing and metrics cardinality bounded through [golang-observability](../../golang-observability/SKILL.md).

## Container runtime limits

- Apply process-wide limits at each executable entrypoint, not in domain or shared library packages.
- Use `go.uber.org/automaxprocs` when the process must match its Linux CPU quota.
- Use `github.com/KimMachineGun/automemlimit` when `GOMEMLIMIT` should follow the cgroup memory limit; keep its 90% default or expose `AUTOMEMLIMIT` for deployment tuning.
- Verify the effective limits inside the built container and rerun load, memory, and race checks before rollout.
