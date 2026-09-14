# Measure and compare

- Define the target metric and acceptable tradeoff before changing code.
- Establish a repeatable baseline with `go test -bench . -benchmem`; isolate the hot path from setup and I/O.
- Use CPU, heap, goroutine, block, mutex, or execution profiles to locate the work before optimizing it.
- Change one variable at a time and compare repeated runs with `benchstat` when available.
- Treat intuition as a hypothesis; keep benchmark inputs, environment, and result files with the review evidence.

## Evaluation gate

- Keep the simpler implementation when the measured gain is immaterial or the change makes the code harder to read.
- Evaluate correctness, allocations, CPU, latency, and memory together; a lower allocation count alone is not a win.
- For micro-optimizations, require a focused benchmark or profile showing the code is on a meaningful hot path.
