# Make Commands (Makefile)

This project uses a `Makefile` to standardize common development tasks. This ensures consistency across local development and CI/CD pipelines.

## 1. Required Make Targets

Your `Makefile` should provide at least the following standard targets:

- **`make run`**: Starts the application locally (e.g., `go run ./cmd/api/main.go`).
- **`make build`**: Compiles the application binaries into a `bin/` directory.
- **`make lint`**: Runs `golangci-lint` to check code quality and formatting.
- **`make test`**: Runs all unit and integration tests.
- **`make coverage`**: Runs tests with coverage profiling and generates an HTML report.
- **`make migrate-up`**: Applies all pending database migrations.
- **`make migrate-down`**: Rolls back the last applied database migration.
- **`make clean`**: Removes compiled binaries and generated coverage files.

## 2. Example Makefile

```makefile
.PHONY: run build lint test coverage migrate-up migrate-down clean

# Variables
APP_NAME=api
BUILD_DIR=bin
MAIN_PATH=cmd/api/main.go
DB_URL="postgres://user:pass@localhost:5432/mydb?sslmode=disable"
MIGRATION_DIR=migrations

# -- Application Execution & Build --

run:
 @echo "Running $(APP_NAME)..."
 go run $(MAIN_PATH)

build:
 @echo "Building $(APP_NAME)..."
 mkdir -p $(BUILD_DIR)
 go build -o $(BUILD_DIR)/$(APP_NAME) $(MAIN_PATH)

clean:
 @echo "Cleaning up..."
 rm -rf $(BUILD_DIR)
 rm -f coverage.out

# -- Quality & Testing --

lint:
 @echo "Running golangci-lint..."
 golangci-lint run ./...

test:
 @echo "Running tests..."
 go test -v -race ./...

coverage:
 @echo "Generating coverage report..."
 go test -coverprofile=coverage.out ./...
 go tool cover -html=coverage.out

# -- Database Migrations (using golang-migrate) --

migrate-up:
 @echo "Applying database migrations..."
 migrate -path $(MIGRATION_DIR) -database $(DB_URL) up

migrate-down:
 @echo "Rolling back database migration..."
 migrate -path $(MIGRATION_DIR) -database $(DB_URL) down 1
```

## 3. Best Practices

- **`.PHONY`:** Always declare targets that don't represent actual files as `.PHONY` to avoid conflicts if a directory or file happens to share the same name (e.g., `test/`).
- **Quiet Echoes:** Prefix your descriptive `echo` commands with `@` so Make doesn't print the `echo` command itself.
- **CI Consistency:** The exact same targets (e.g., `make lint`, `make test`) should be used inside your `.gitlab-ci.yml` or GitHub Actions scripts.
