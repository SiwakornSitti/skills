# Memory and CPU

- Reduce allocations only after profiling identifies them; inspect escape analysis and allocation counts.
- Prefer appropriate algorithms and data structures before micro-optimizing syntax.
- Avoid reflection, repeated conversions, and unnecessary copies on measured hot paths.
- Consider layout, pooling, and reuse only when benchmarks show a durable win and ownership remains clear.
- Do not use `unsafe` as a performance shortcut without a reproducible benchmark and a correctness test.
