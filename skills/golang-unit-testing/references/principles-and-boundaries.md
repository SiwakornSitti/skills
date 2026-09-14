# Unit-test principles and boundaries

Write isolated, fast tests for one layer of a Go service built with Hexagonal
Architecture. Unit tests use in-memory values and test doubles; they do not
start databases, caches, brokers, network listeners, or filesystem workflows.

## Scope

Unit-test one of these units at a time:

- Pure domain functions and methods.
- Use cases and services through their outbound ports.
- HTTP handlers through `net/http/httptest` and the repository's Gorilla Mux
  router.
- Consumer handlers by passing message bytes directly to the handler.

Use [golang-integration-testing](../../golang-integration-testing/SKILL.md) for
database, cache, broker, filesystem, and real network behavior. Do not turn a
unit test into an integration test to avoid designing a test double.

## Core principles

1. Test observable behavior: returned values, errors, state changes, response
   contracts, and port interactions that are part of the contract.
2. Keep the production boundary visible. Inject repositories, unit of work
   ports, clocks, ID generators, cross-context services, and other effects.
3. Use the standard `testing` package first. Preserve existing Testify usage
   where it is already established, especially for generated Mockery mocks.
4. Keep setup local to the test or subtest. Shared fixtures must not hide the
   behavior being verified or carry mutable state between cases.
5. Test failure paths as deliberately as success paths.

## Test naming

Name behavior tests as `Test<Subject>_Expect<ExpectedResult>When<Condition>`:

```go
func TestIssue_ExpectCardWhenAccountExists(t *testing.T) {}
func TestIssue_ExpectNotFoundWhenAccountIsMissing(t *testing.T) {}
func TestActivate_ExpectInvalidStatusWhenCardIsAlreadyActive(t *testing.T) {}
```

Name table cases as `expect_<result>_when_<condition>`, such as
`expect_card_when_account_exists`, `expect_not_found_when_account_is_missing`,
and `expect_400_when_field_is_unknown`. Apply this to the `name` field as well
as `t.Run` labels; replace vague names such as `success`, `error`, or `case1`.

Do not optimize for a coverage percentage. A useful test fails when a contract
breaks, not when an implementation line is rearranged.

## Test organization

Place tests beside production code in `_test.go` files. Prefer an external test
package for public behavior; use the internal package when unexported logic is
intentionally the unit boundary.

Keep fixtures minimal and local. Add a builder only when repeated setup hides
the scenario, and keep builder defaults obvious. Do not create a fixture
factory or test framework for one package.
