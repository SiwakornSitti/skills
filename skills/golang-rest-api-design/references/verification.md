# Verification

- Verify routes through a `mux.Router`, not only by calling a handler method
  directly. This catches path variables, method constraints, and middleware
  behavior.
- Test the happy path and each applicable failure mapping: malformed JSON,
  validation, missing resources, conflicts, domain rejection, and unexpected
  service errors.
- Assert status, `Content-Type`, and decoded JSON—not only a non-error return.
- Run `make gen-docs` and `go test ./...` when annotations or shared HTTP
  helpers change. Focused handler tests are enough for an isolated endpoint.
