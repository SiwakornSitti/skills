# Boundaries

## Handler ownership

- Keep HTTP handlers in `internal/<context>/inbound/http/`.
- Decode transport DTOs, translate them into domain commands, and invoke the
  context's `domain.Service` or `domain.UseCase`.
- Keep repositories and other bounded contexts behind domain ports; handlers do
  not call them directly.
- Pass the authenticated identity from middleware to the use case. A path or
  user header identifies a request target, not proof of authorization; keep
  authorization policy outside this skill.
- Pass `r.Context()` through the use case. Do not create detached request work
  or read from unrelated contexts in a handler.
