# Resilience and partial failure

Give every BFF request one total deadline and divide it into per-upstream budgets. A child call must not outlive the inbound request. Propagate cancellation when a required call fails or the client disconnects.

Classify each upstream call as required or optional before implementation:

| Call | Failure policy |
| --- | --- |
| Required data | fail the endpoint with a stable client-facing error |
| Optional enrichment | return the base view and an explicit omission/degraded marker |
| Side effect | use the owning service’s idempotency and workflow contract; do not fake success |

Retry only transient failures and only when the operation is safe under the upstream contract. Use a small bounded attempt count, exponential backoff with jitter, and the remaining request deadline. Never retry validation failures, authorization failures, malformed responses, or non-idempotent writes without an idempotency contract.

Avoid retry multiplication: one layer should own retries for a given call. A BFF retrying a core service that already retries its database call can turn a short outage into overload.

Bound fan-out, response size, and concurrency. Use a circuit breaker or bulkhead only when the repository already has an adopted implementation and measured need; otherwise explicit deadlines, cancellation, and bounded retries are the baseline.

Never convert a required upstream failure into an empty successful response. If partial responses are allowed, make degraded state observable and test it.
