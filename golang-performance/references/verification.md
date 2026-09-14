# Verification

- Record the baseline, change, environment, benchmark command, and result comparison.
- Re-run focused benchmarks and relevant unit, integration, and race tests after each optimization.
- Check tail latency, allocations, CPU, memory, and correctness; a faster incorrect result is a regression.
- Roll out high-risk changes behind a bounded deployment or feature control when production behavior is uncertain.
