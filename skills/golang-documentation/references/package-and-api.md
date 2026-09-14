# Package and API documentation

- Add a package comment for exported packages; start exported declaration comments with the declared name.
- Document behavior, invariants, error outcomes, ownership, blocking, cancellation, and concurrency expectations when they affect callers.
- Explain why a surprising constraint exists; do not restate obvious syntax or implementation details.
- Keep names and examples aligned with [golang-idioms](../../golang-idioms/SKILL.md) and error contracts aligned with [golang-error-handling](../../golang-error-handling/SKILL.md).
- Preserve compatibility promises deliberately; documentation is part of the public API.
