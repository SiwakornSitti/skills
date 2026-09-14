# Metrics

- Use counters for completed work, failures, retries, and dropped messages;
  histograms for duration and sizes; and gauges only for current state such as
  in-flight work or backlog.
- Use stable names and units, and document the unit in the instrument
  definition.
- Keep labels bounded and low-cardinality: operation, route template, status
  class, outcome, dependency, and error code.
- Never use request IDs, account IDs, email addresses, transaction IDs, raw
  URLs, SQL text, exception messages, or unbounded user-agent values as labels.
- Prefer status classes such as `2xx`, `4xx`, and `5xx` when exact codes are
  not required for an alert. Never create labels dynamically from input.
- Record duration and outcome once per operation. Do not duplicate middleware
  timers in every handler.
- Use metrics for aggregation and alerting; use logs for selected details.

Choose the lowest-cost signal that answers the operational question.
