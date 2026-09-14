---
name: golang-performance
description: Optimize measured Go bottlenecks across CPU, allocations, I/O, runtime, caching, and database access. Use when a benchmark, profile, trace, or production measurement identifies a performance problem.
license: MIT
compatibility: "Requires Go 1.22+."
metadata:
  version: "1.0"
  tags: [go, performance, benchmarks, profiling, pprof, optimization]
---

# Go performance

Read the reference matching the performance concern:

- [measure-and-compare.md](references/measure-and-compare.md) — targets, baselines, profiling, and benchmark comparison.
- [memory-and-cpu.md](references/memory-and-cpu.md) — allocations, escape behavior, CPU work, and data layout.
- [io-and-runtime.md](references/io-and-runtime.md) — external waits, pools, serialization, GC, and runtime limits.
- [caching-and-database.md](references/caching-and-database.md) — repeated work, cache tradeoffs, and query handoff.
- [verification.md](references/verification.md) — regression evidence and safe rollout.

Keep production telemetry in [golang-observability](../golang-observability/SKILL.md), SQL-specific tuning in [golang-sql](../golang-sql/SKILL.md), and concurrency design in [golang-concurrency](../golang-concurrency/SKILL.md).

Completion check: identify a measured bottleneck, make one bounded change, and retain before/after evidence.

## Related skills

- [golang-sql](../golang-sql/SKILL.md)
- [golang-observability](../golang-observability/SKILL.md)
- [golang-troubleshooting](../golang-troubleshooting/SKILL.md)
- [golang-cache](../golang-cache/SKILL.md)
