# Detailed guidance

# Mockery Port Mocking Skill

This skill guides engineers on generating, configuring, and using test doubles for Hexagonal Architecture domain ports using [Mockery v3](https://github.com/vektra/mockery).

---

## 1. Mockery Configuration (`.mockery.yaml`)

All mock generation settings are centralized in [`.mockery.yaml`](file:///Users/ar677101/Desktop/Project/it-strategy/go-project-structure/.mockery.yaml) at the repository root:

```yaml
template: testify
dir: "{{.InterfaceDir}}/mocks"
filename: "mock_{{.InterfaceName | lower}}.go"
pkgname: "mocks"
packages:
  github.com/example/go-hexagonal/internal/account/domain:
    config:
      all: true
  github.com/example/go-hexagonal/internal/user/domain:
    config:
      all: true
  github.com/example/go-hexagonal/internal/notification/domain:
    config:
      all: true
```

### Key Configuration Directives

- **`template: testify`**: Generates type-safe mocks extending `github.com/stretchr/testify/mock`.
- **`dir: "{{.InterfaceDir}}/mocks"`**: Places mocks directly beside domain ports in a dedicated `mocks` subpackage (e.g. `internal/account/domain/mocks/`).
- **`pkgname: "mocks"`**: Prevents circular dependencies by isolating mock code from the domain package.
- **`all: true`**: Automatically generates mocks for all interfaces in the specified package (`Service`, `Repository`, `UnitOfWork`, etc.).

---

## 2. Generating Mocks

Regenerate mocks whenever domain port interfaces change or new bounded contexts are created:

```bash
# Generate mocks using the Makefile target
make gen-mock

# Or run mockery directly
mockery
```

---

## 3. Mock Instantiation & Expectation Patterns

### Constructor with `*testing.T` Binding

Always instantiate mocks passing the active `t *testing.T`. This automatically binds cleanup to verify that all mock expectations were satisfied before the test finishes:

```go
repo := mocks.NewMockRepository(t)
uow := mocks.NewMockUnitOfWork(t)
uowFactory := mocks.NewMockUnitOfWorkFactory(t)
```

### Basic Return Expectations

```go
// Match exact argument
repo.On("FindByID", mock.Anything, "acc-100").Return(&domain.Account{
    ID:      "acc-100",
    Balance: 5000,
}, nil)

// Return an error
repo.On("FindByID", mock.Anything, "missing-id").Return(nil, domain.ErrNotFound)
```

### Custom Argument Matchers (`mock.MatchedBy`)

Verify payload fields or internal state without requiring strict pointer equality:

```go
repo.On("Save", mock.Anything, mock.MatchedBy(func(a *domain.Account) bool {
    return a.UserID == "user-1" && a.Currency == "USD" && a.Balance == 0
})).Return(nil)
```

### Call Count & Once Constraints

```go
// Expect method to be called exactly once
repo.On("Delete", mock.Anything, "acc-1").Return(nil).Once()

// Expect method to never be called
repo.AssertNotCalled(t, "Delete", mock.Anything, mock.Anything)
```

---

## 4. Anti-Patterns to Avoid

- **Do Not Edit Generated Files**: Never manually edit files in `mocks/`. Modify the interface in `domain/` and rerun `make gen-mock`.
- **Do Not Mock Concrete Types**: Mockery only works on Go interfaces. If you need to mock a component, define an interface port in `domain/`.
- **Avoid Global/Reused Mock Instances**: Always create fresh mock instances per test case to avoid cross-test call leakage.
