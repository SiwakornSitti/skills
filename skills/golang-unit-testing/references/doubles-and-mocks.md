# Test doubles and mocks

Choose the smallest double that represents the behavior needed by the test:

- Use a handwritten fake when state transitions or returned values matter.
- Use a stub when the test needs only a fixed response.
- Use an expectation-based mock when call count, arguments, or ordering is a
  meaningful port contract.
- Use generated Mockery mocks when the repository already owns that generated
  port mock; read [golang-mockery](../../golang-mockery/SKILL.md) for generation
  and maintenance.

Keep mocks and fakes behind the outbound interface. Do not mock the function
under test, standard-library values, or every internal helper.

Create a fresh double for every `t.Run` case. Bind generated and handwritten
mock cleanup to `testing.T` so unmet expectations fail in the owning test.
Never regenerate mocks implicitly while running tests.

## Existing repository pattern

Generated mocks are commonly constructed with `testing.T`:

```go
repo := mocks.NewMockRepository(t)
uow := mocks.NewMockUnitOfWork(t)
uowFactory := mocks.NewMockUnitOfWorkFactory(t)
```

Use `mock.MatchedBy` for pointer arguments when the test cares about selected
fields rather than pointer identity. Use broad matchers such as
`mock.Anything` only where the value is not part of the behavior under test.

Handwritten Testify mocks are acceptable for small packages, but they must
still isolate state per test and register cleanup for expectations.
