# Client contracts and data shaping

Treat the BFF response as a deliberate client contract. Do not pass through raw core-service JSON, generated protobuf structs, database rows, or every upstream field.

Define explicit response DTOs containing an allowlisted, client-useful subset. Name fields for the client contract, normalize representation at the BFF boundary, and keep internal/core models private to their owning package.

```go
type AccountSummary struct {
	ID      string `json:"id"`
	Balance Money  `json:"balance"`
}
```

Contract rules:

- document required fields, nullability, ordering, pagination, and partial-data markers;
- make additive changes backward-compatible and version breaking changes deliberately;
- never expose secrets, access tokens, internal URLs, stack traces, or fields the client does not need;
- preserve stable identifiers and units; do not silently change currency, timestamps, or status meanings;
- distinguish “not requested,” “not found,” and “temporarily unavailable” where the client needs different behavior;
- keep mapping code near the BFF use case or adapter, with tests for absent, malformed, and extra upstream fields.

If a client needs a new domain fact, extend the owning core-service contract rather than reconstructing it from several unrelated responses.
