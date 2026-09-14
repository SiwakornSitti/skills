---
name: golang-troubleshooting
description: Diagnose Go build failures, crashes, races, deadlocks, slow paths, and unexpected behavior from reproduction to root cause. Use when Go code is failing, hanging, flaky, or unexpectedly slow.
license: MIT
compatibility: "Requires Go 1.22+; optional Delve and pprof tooling improve diagnosis."
metadata:
  version: "1.0"
  tags: [go, troubleshooting, debugging, race, pprof, diagnosis]
---

# Go troubleshooting

Read the reference matching the failure:

- [workflow.md](references/workflow.md) — reproduction, hypotheses, instrumentation, and root cause.
- [build-and-tests.md](references/build-and-tests.md) — compiler, vet, test, and flaky-test diagnosis.
- [concurrency-and-races.md](references/concurrency-and-races.md) — races, deadlocks, leaks, and cancellation.
- [profiles-and-runtime.md](references/profiles-and-runtime.md) — pprof, trace, GODEBUG, and optional Delve.
- [production-evidence.md](references/production-evidence.md) — logs, metrics, traces, and safe evidence collection.
- [verification.md](references/verification.md) — regression proof and handoff.

Use the global `diagnosing-bugs` skill for the generic diagnosis loop when available; keep Go-specific commands and runtime evidence here. Use [golang-performance](../golang-performance/SKILL.md) for optimization after the bottleneck is known.

Completion check: reproduce or clearly bound the failure, explain the root cause, and leave a regression check.

## Related skills

- [golang-safety](../golang-safety/SKILL.md)
- [golang-concurrency](../golang-concurrency/SKILL.md)
- [golang-observability](../golang-observability/SKILL.md)
- [golang-unit-testing](../golang-unit-testing/SKILL.md)
