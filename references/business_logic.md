# Business Logic and Feature Implementation

## 1. Package Structure & Layers

- **Package by Feature:** Each feature should be in its own package inside `/internal` (e.g., `/internal/order`).
- **Layers:** Within a feature package, each layer **must** be wrapped in its own sub-folder to ensure strict separation of concerns and clear package boundaries. Each folder should also contain its own unit tests.
  - `handler/`: Handles transport-level concerns (e.g., parsing HTTP requests, validating input DTOs, formatting JSON responses). It relies on the `service` interface to execute business rules. Includes `handler_test.go`.
  - `service/`: Contains the pure core business logic and state validation. This layer **must not** know anything about HTTP, gRPC, or SQL. It depends on `repository` interfaces. Includes `service_test.go`.
  - `repository/`: Handles data access, persistence, and external API calls. This layer translates database records into pure domain models before returning them to the service. Includes `repository_test.go`.
  - **Note on Caching:** Caching logic (e.g., checking Redis before querying PostgreSQL) should generally be implemented at the `repository` layer, keeping the `service` layer entirely unaware of the storage implementation details. Alternatively, use a caching decorator over the repository interface.

## 2. Flow of Control (The Dependency Rule)

To maintain clean architecture, dependencies must only point **inward** toward the business logic:

1. **`cmd`** injects dependencies into `handler`.
2. **`handler`** depends on `service` (usually via an interface). It parses the HTTP request, calls the service, and formats the HTTP response.
3. **`service`** contains the pure business rules. It depends on `repository` (strictly via an interface) to fetch or save data.
4. **`repository`** depends on the database driver (`database/sql`, `sqlc`, etc.) to execute queries and return domain models back to the service.

## 3. Additional Best Practices

- **Dependency Injection (DI):** Always pass dependencies (like database connections, cache clients, or other services) via constructors (e.g., `NewService(repo Repository)`). Never use global variables for state or database connections.
- **Context Passing:** Always pass `context.Context` as the first parameter to functions in the `handler`, `service`, and `repository` layers. This is critical for timeouts, cancellation, and distributed tracing.
- **Data Transfer Objects (DTOs):** Handlers should parse incoming requests into DTOs, validate them, and map them to Domain Models *before* passing them to the Service layer. The Service layer should only accept and return Domain Models.
- **Fat Models, Thin Controllers:** Keep handlers as thin as possible. Move complex data transformations and business rules into the `service` layer or domain models.
- **Interfaces Belong to Consumers:** Define interfaces where they are *used*, not where they are *implemented*. For example, the `service` package should define the `Repository` interface it requires, and the `repository` package implements it.
