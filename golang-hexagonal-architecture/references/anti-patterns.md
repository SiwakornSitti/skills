# Hexagonal Architecture Anti-Patterns & Remediations

This reference details architectural traps to identify and eliminate when designing or refactoring bounded contexts.

---

## 1. Leaking Infrastructure into Domain Contracts

- **Anti-Pattern**: Domain ports accept or return database types, driver connections, or HTTP headers.
  ```go
  // BAD: Domain imports database/sql or pgx
  type UserRepository interface {
      FindByID(ctx context.Context, tx *sql.Tx, id string) (*User, error)
  }
  ```
- **Remediation**: Keep domain ports pure and agnostic of persistence technology. Use Unit of Work or contextual transaction management instead of passing raw transaction handles.
  ```go
  // GOOD: Domain depends only on domain entities and context
  type UserRepository interface {
      FindByID(ctx context.Context, id string) (*User, error)
  }
  ```

---

## 2. Passing Transport Types to Service or UseCase

- **Anti-Pattern**: Services or usecases accept `*http.Request`, `http.ResponseWriter`, or gin/echo/mux context objects.
  ```go
  // BAD: Service tied to HTTP protocol
  func (s *UserService) CreateUser(w http.ResponseWriter, r *http.Request) error
  ```
- **Remediation**: The inbound adapter unwraps, validates, and deserializes protocol data into a plain domain command or DTO before calling the service.
  ```go
  // GOOD: Clean domain command
  type CreateUserCommand struct {
      Email string
      Name  string
  }
  func (s *UserService) CreateUser(ctx context.Context, cmd CreateUserCommand) (*User, error)
  ```

---

## 3. Cross-Context Internal Imports (Modular Monolith Leakage)

- **Anti-Pattern**: Bounded Context A imports B's internal repository, database model, or concrete service.
  ```go
  // BAD: Order context reaching into Account internals
  import "github.com/example/go-hexagonal/internal/account/outbound/repository/db"
  ```
- **Remediation**: Context A's usecase defines a narrow caller-owned port. A tiny adapter may be wired in `module.go`; an adapter with mapping logic belongs under `outbound/<dependency>/`, accepts Context B's exported domain contract, and is wired by `module.go` or `cmd/server/main.go`.

---

## 4. Generic CRUD Repositories

- **Anti-Pattern**: Defining `Repository[T any]` with generic `Create`, `Update`, `Delete` methods across all entities.
- **Remediation**: Define aggregate-specific ports that express explicit domain intent (`FindOverdueLoans`, `SaveWithAudit`) rather than generic storage mechanisms.

---

## 5. Constructing Adapters Inside Business Logic

- **Anti-Pattern**: Domain entities or services instantiating database clients, HTTP clients, or loggers inside their constructors or methods.
- **Remediation**: Enforce Dependency Inversion. All concrete infrastructure is constructed at the composition root (`module.go` or `cmd/`) and passed as interfaces to service constructors.

---

## 6. Distributed Transactions Across Contexts

- **Anti-Pattern**: Sharing a single SQL transaction across multiple bounded contexts to achieve atomicity.
- **Remediation**: Maintain local transactions per bounded context. Coordinate multi-context state transitions asynchronously using the Transactional Outbox pattern or Saga orchestration.
