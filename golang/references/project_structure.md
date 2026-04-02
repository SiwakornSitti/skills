# Project Structure

This project follows a **"Package by Feature"** directory structure. Instead of grouping files by their technical role (e.g., all handlers together, all repositories together), code is organized by the business capability it provides. This maximizes cohesion, reduces inter-package dependencies, and makes features much easier to locate, modify, and scale.

## 1. Directory Layout

*Caption: Package-by-Feature Directory Structure*

```text
/
├── cmd/                                    # Entry points for the applications
│   ├── api/                                # HTTP REST API server
│   │   └── main.go
│   └── worker/                             # Background job processor
│       └── main.go
├── configs/                                # Configuration files (e.g., config.yaml)
├── docs/                                   # Swagger/OpenAPI specs and documentation
├── internal/                               # Private application code (cannot be imported externally)
│   ├── account/                            # Feature: Account Management
│   │   ├── handler/                        # Transport layer (HTTP routing, parsing, response)
│   │   │   ├── handler.go
│   │   │   └── handler_test.go
│   │   ├── service/                        # Core business logic and validation
│   │   │   ├── service.go
│   │   │   └── service_test.go
│   │   └── repository/                     # Data access layer (DB, external APIs)
│   │       ├── repository.go
│   │       └── repository_test.go
│   ├── inventory/                          # Feature: Inventory Management
│   │   └── ...
│   └── shared/                             # Cross-cutting concerns & shared models
│       └── models/
├── migrations/                             # Database schema versioning scripts (e.g., SQL files)
│   └── 20260330000001_initial_schema.sql
├── .gitlab-ci.yml                          # CI/CD pipeline definition
├── Dockerfile                              # Containerization instructions
└── go.mod                                  # Go module dependencies
```

## 2. Key Directories Explained

- 🚀 **`/cmd` (Entry Points):** Contains the `main.go` files for the different executable applications within the project (e.g., an HTTP `api` server, a background `worker`, or a CLI tool). These files should be kept very small, handling only dependency injection, configuration parsing, and application startup/shutdown.
- ⚙️ **`/configs` (Configuration):** Stores configuration file templates or default configs (e.g., `config.yaml`, `.env.example`).
- 📖 **`/docs` (Documentation):** Contains design documents, Swagger/OpenAPI generated specifications (`swagger.json`), and other project documentation.
- 🔒 **`/internal` (Private Application Code):** The heart of the application. The Go compiler strictly prevents external projects from importing code placed within an `internal` directory.
  - **Feature Packages:** Sub-directories (like `account` or `inventory`) encapsulate everything needed for a specific business domain.
  - **Layer Isolation:** Inside each feature, code is isolated into sub-folders (`handler`, `service`, `repository`). For specific rules on how these layers interact, see **Section 4: Feature Implementation & Layers** below.
  - **Shared Code:** Use `internal/shared` for foundational code, domain events, or models that must be accessed by multiple features (to prevent circular dependencies).
- 📦 **`/pkg` (Public Library Code - Optional):** If you are writing foundational library code that is explicitly intended to be imported and used by *other* repositories, it goes here. Do not use `/pkg` for internal business logic.
- 🗄️ **`/migrations` (Database Schema):** Contains version-controlled SQL scripts required to construct and alter the database schema safely over time.

## 3. Root Level Files

- 🛠️ **`Makefile`**: Contains standardized commands for common development tasks (e.g., `make build`, `make test`, `make lint`).
- ⚙️ **`.gitlab-ci.yml`**: Defines the automated CI/CD pipeline (linting, testing, building, deployment).
- 🐳 **`Dockerfile`**: Provides the containerization instructions for deploying the applications.
- 📝 **`README.md`**: Project overview, setup instructions, and usage examples.
- 📦 **`go.mod`**: Defines the module path and manages project dependencies.

---

## 4. Feature Implementation & Layers

Within an `/internal` feature package, each layer **must** be wrapped in its own sub-folder to ensure strict separation of concerns and clear boundaries. Each folder should also contain its own unit tests.

- `handler/`: Handles transport-level concerns (e.g., parsing HTTP requests, validating input DTOs, formatting JSON responses). It relies on the `service` interface to execute business rules. Includes `handler_test.go`.
- `service/`: Contains the pure core business logic and state validation. This layer **must not** know anything about HTTP, gRPC, or SQL. It depends on `repository` interfaces. Includes `service_test.go`.
- `repository/`: Handles data access, persistence, and external API calls. This layer translates database records into pure domain models before returning them to the service. Includes `repository_test.go`.
- **Note on Caching:** Caching logic (e.g., checking Redis before querying PostgreSQL) should generally be implemented at the `repository` layer, keeping the `service` layer entirely unaware of the storage implementation details. Alternatively, use a caching decorator over the repository interface.

## 5. Flow of Control (The Dependency Rule)

To maintain clean architecture, dependencies must only point **inward** toward the core business logic:

1. **`cmd`** injects dependencies into `handler`.
2. **`handler`** depends on `service` (usually via an interface). It parses the HTTP request, calls the service, and formats the HTTP response.
3. **`service`** contains the pure business rules. It depends on `repository` (strictly via an interface) to fetch or save data.
4. **`repository`** depends on the database driver (`database/sql`, `sqlc`, etc.) to execute queries and return domain models back to the service.

## 6. Additional Best Practices

- **Dependency Injection (DI):** Always pass dependencies (like database connections, cache clients, or other services) via constructors (e.g., `NewService(repo Repository)`). Never use global variables for state or database connections.
- **Context Passing:** Always pass `context.Context` as the first parameter to functions in the `handler`, `service`, and `repository` layers. This is critical for timeouts, cancellation, and distributed tracing.
- **Data Transfer Objects (DTOs):** Handlers should parse incoming requests into DTOs, validate them, and map them to Domain Models *before* passing them to the Service layer. The Service layer should only accept and return Domain Models.
- **Fat Models, Thin Controllers:** Keep handlers as thin as possible. Move complex data transformations and business rules into the `service` layer or domain models.
- **Interfaces Belong to Consumers:** Define interfaces where they are *used*, not where they are *implemented*. For example, the `service` package should define the `Repository` interface it requires, and the `repository` package implements it.
