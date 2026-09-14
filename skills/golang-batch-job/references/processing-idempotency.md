# Processing and idempotency

- Keep workers stateless and make each item idempotent so duplicate delivery,
  concurrent claims, and retries are safe.
- Use a stable item identity to detect or safely repeat work. Make the side
  effect and its completion state consistent with the workload contract.
- Keep detailed idempotency mechanisms in `golang-idempotent`; this skill
  requires item-level duplicate safety for batch processing.
