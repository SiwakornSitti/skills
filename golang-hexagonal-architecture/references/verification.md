# Hexagonal Architecture Verification

Use this checklist and verification suite to validate architectural compliance before completing any code changes.

---

## 1. Automated Architecture Verification Script

Run the skill's dedicated boundary verification script:

```bash
.agents/skills/golang-hexagonal-architecture/scripts/verify_hexagonal.sh
```

This script automatically verifies:
- **Domain Purity**: Ensures `internal/*/domain` imports zero database drivers, HTTP protocols, or infrastructure packages.
- **Service Isolation**: Ensures `internal/*/service` does not import `net/http` or raw database drivers.
- **Cross-Context Boundaries**: Ensures bounded contexts do not import another context's internal adapters.

---

## 2. Manual Inspection Checklist

1. **Domain Package Purity**:
   - `domain/` must depend only on Go standard library primitives (`context`, `errors`, `time`).
   - Run:
     ```bash
     go list -f '{{.ImportPath}}: {{.Imports}}' ./internal/... | grep '/domain:'
     ```
2. **Inbound & Outbound Ports**:
   - Handlers and consumers call domain ports or use cases, never concrete service structs or database repositories directly.
   - Outbound adapters implement domain repository/port interfaces.
3. **Composition Root Integrity**:
   - Concrete constructors (`NewRepository`, `NewHandler`, `NewService`) are called exclusively in `module.go` or `cmd/server/main.go`.
   - Business logic never reads environment variables or instantiates database clients.
4. **Cross-Context Isolation**:
   - Context A never imports `internal/<contextB>/service`, `internal/<contextB>/outbound`, or `internal/<contextB>/inbound`.
   - Cross-context workflows live in `usecase/` and depend on caller-owned narrow ports.
   - Foreign domain contracts and translation are isolated in module wiring or `outbound/<dependency>/` adapters.

---

## 3. Test & Lint Verification

Execute the test suite and repository linters:

```bash
# Compile and run all unit tests
go test ./...

# Verify depguard cross-context import boundaries
golangci-lint run --disable-all -E depguard
```
