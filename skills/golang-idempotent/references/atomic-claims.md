# Atomic claims

- Claim a key atomically before executing side effects with a database
  uniqueness constraint or equivalent conditional store operation.
- Represent at least `in_progress` and `completed` states. A read-then-write
  check is unsafe under concurrent requests.
- Define the behavior for an existing in-progress claim, such as bounded
  waiting, a retryable response, or an explicit conflict.
- Do not execute the operation when the claim belongs to another request.
