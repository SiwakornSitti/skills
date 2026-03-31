# Testing

## 1. Unit Testing

- **Requirement:** All new business logic **must** be accompanied by unit tests. Strive for high test coverage in the `service` and `handler` layers.
- **Coverage Goal:** The project aims for a minimum of **80% code coverage** for core business logic (`service` layer). Use `go test -coverprofile=coverage.out` to generate coverage reports and `go tool cover -html=coverage.out` to visualize missing areas.
- **Location:** Tests must be placed inside the same folder (and package) as the code they are testing. For feature layers, this means:
  - `handler/handler_test.go`
  - `service/service_test.go`
  - `repository/repository_test.go`
- **Table-Driven Tests:** Prefer using Table-Driven tests for testing multiple scenarios (successes and errors) of the same function. This is an idiomatic Go practice that keeps test files clean, concise, and easy to scale.
- **Mocks:** Mocks for interfaces should be generated via tools like `mockgen` or written manually to isolate the unit being tested.

### Example Table-Driven Test

```go
func TestValidateEmail(t *testing.T) {
 tests := []struct {
  name    string
  email   string
  wantErr bool
 }{
  {"Valid Email", "test@example.com", false},
  {"Missing @", "testexample.com", true},
  {"Empty String", "", true},
  {"Valid Subdomain", "user@mail.example.co.uk", false},
 }

 for _, tt := range tests {
  t.Run(tt.name, func(t *testing.T) {
   err := ValidateEmail(tt.email)
   if (err != nil) != tt.wantErr {
    t.Errorf("ValidateEmail() error = %v, wantErr %v", err, tt.wantErr)
   }
  })
 }
}
```

## 2. Integration Testing (Database)

- **Requirement:** Code that interacts directly with external systems, specifically the `repository` layer, **must** be tested using integration tests.
- **Testcontainers:** Do **not** use `sqlmock` or similar database mocking tools, as they often lead to false positives (e.g., passing tests for invalid SQL syntax). Instead, use `testcontainers-go` to spin up a real, ephemeral database container (e.g., PostgreSQL, MySQL) during the test run.
- **Migrations:** Before running repository integration tests, apply the latest database migrations to the Testcontainer instance to ensure the schema strictly matches production.
- **Data Isolation:** Each test case should ideally run in its own transaction or ensure it cleans up its own data to prevent test pollution.

## 3. Contract Testing

- **Requirement:** When developing services that communicate with other internal microservices or external APIs, use contract testing to ensure compatibility and prevent breaking changes.
- **Tools:** Utilize tools like Pact (via `pact-foundation/pact-go`) to define and verify interactions between consumers and providers.
- **CI/CD Integration:** Contract verification should be automated in the CI pipeline to ensure that no deployment breaks the expected contract of API consumers.
