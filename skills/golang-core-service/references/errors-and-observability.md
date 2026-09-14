# Errors and observability

Define domain errors for stable business outcomes such as not found, conflict, invalid transition, and forbidden operation. Wrap infrastructure failures with context while preserving matching via `errors.Is` or `errors.As`. Translate errors once at each external boundary.

Do not log the same error at every layer. Add structured context at the boundary that owns the final outcome, including operation and bounded identifiers; omit tokens, credentials, and sensitive payloads. Record upstream or dependency failures with the shared observability conventions.

Measure business outcomes and dependency health with bounded labels. Trace inbound-to-use-case-to-adapter flow when tracing is enabled, propagate cancellation, and mark failures according to the actual result. Avoid logging or labeling raw request bodies, user data, or unbounded IDs.
