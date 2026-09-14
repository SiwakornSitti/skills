# Verification and Troubleshooting

## Workflow

For a contract change:

1. Inspect the handler, registration, DTOs, and `pkg/httpserver` helpers.
2. Update annotations to match reachable runtime behavior.
3. Compare every `@Router` path and method with `RegisterRoutes`.
4. Run `make gen-docs` with a compatible Swaggo version.
5. Review every generated diff, including schemas and paths.
6. Run focused handler tests.

Use repository searches as a lightweight parity check; do not add a custom
validator until repeated failures justify maintaining one. A route without a
matching annotation, or an annotation without a registered route, is drift.

```bash
rg -n 'HandleFunc\(|@Router' internal/*/inbound/http
go test ./internal/account/inbound/http/...
make gen-docs
git diff -- docs/docs.go docs/swagger.yaml
```

Run the Swagger UI at `/swagger/` or inspect the generated specification when a
route, schema, status, or serving path changes. Annotation-only edits need the
focused tests and generated diff; they do not require a live server.

## Troubleshooting

- Missing paths: compare `RegisterRoutes`, `@Router`, generator entrypoint, and
  Swaggo version.
- Wrong collection schema: verify the handler returns the page wrapper and use a
  concrete named response model.
- Missing error fields: verify the referenced `ErrorResponse` type and its JSON
  tags; runtime responses contain both `code` and `error`.
- Missing failure status: trace every `WriteError` branch, including generic
  internal errors.
- Unexpected generated churn: check `swag --version` before accepting output.

Completion means route and annotation parity, accurate request/response schemas,
reviewed generated artifacts, and passing focused handler tests.
