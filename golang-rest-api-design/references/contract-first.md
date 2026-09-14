# Contract-first

Before editing a handler:

1. Read the relevant topic in `docs/restful/` and inspect the existing route,
   DTO, service port, error values, and neighboring handler tests.
2. Record the public contract: method, path, identity or idempotency behavior,
   request fields, response shape, status codes, and stable error codes.
3. Change the smallest boundary needed. Keep business rules in the service or
   use case and transport translation in the handler.

Treat paths, methods, JSON names, status codes, error codes, pagination fields,
and timestamp formats as public API. Breaking changes need an explicit
migration or versioning decision and contract tests.
