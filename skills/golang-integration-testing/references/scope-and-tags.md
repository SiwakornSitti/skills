# Scope and tags

Integration tests verify outbound adapters (`outbound/repository/`, cache, `pkg/outbox`) against real infrastructure or services.

- Every integration test file starts with `//go:build integration` so `go test ./...` stays fast and infrastructure-free.
- Keep business rules in unit tests; use integration tests for SQL, constraints, transactions, serialization, TTL, and service behavior.
