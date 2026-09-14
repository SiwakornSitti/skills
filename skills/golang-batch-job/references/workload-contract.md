# Workload contract

Define the item boundary and identity, completion state, retry policy,
throughput target, acceptable lag, and delivery guarantee before choosing
infrastructure.

- Preserve ordering only within a required partition or business key. Treat
  global ordering as an explicit business contract because it limits scale.
- Keep scheduling and orchestration outside this skill unless they change
  claiming, retry, or restart behavior.
