# Docker & Containerization

This document outlines the requirements and best practices for creating Docker images for the Go applications in this project.

## 1. Multi-Stage Builds

All `Dockerfile`s **must** use multi-stage builds. This ensures that the final production image is as small and secure as possible, containing only the compiled binary and necessary runtime assets.

- **Builder Stage:** Use an official Go image (e.g., `golang:1.26-alpine` or newer) to download dependencies, run tests (optional but recommended), and compile the binary.
- **Final Stage:** Use a minimal base image (e.g., `alpine:latest`, `scratch`, or `gcr.io/distroless/static-debian12`) to run the compiled binary.

## 2. Compilation Flags

When compiling the Go binary in the builder stage, use flags to optimize the output for a containerized environment:

- `CGO_ENABLED=0`: Disables cgo. This is critical for creating a statically linked binary that can run on minimal base images like `scratch` or `alpine` without requiring C libraries.
- `-ldflags="-s -w"`: Strips debugging information and symbol tables, significantly reducing the final binary size.
- `GOOS=linux` and `GOARCH=amd64` (or `arm64`): Ensure the binary is compiled for the correct target architecture, regardless of the host machine building it.

## 3. Security and Privileges

- **Non-Root User:** The application **must not** run as the `root` user inside the container. Create a dedicated unprivileged user and group in the final stage and switch to it using the `USER` directive.
- **Minimal Base Image:** Prefer `scratch` or distroless images over `alpine` or `debian` if you do not need shell access in production. This drastically reduces the attack surface.

## 4. Signal Handling (No Tini Needed)

Unlike Node.js or Python applications, a statically compiled Go binary running as PID 1 handles OS signals (like `SIGTERM` and `SIGINT`) natively and correctly.

- **No `tini` or `dumb-init`:** You do **not** need an init process wrapper like `tini` when running a compiled Go binary in a Docker container, provided your application implements graceful shutdown logic properly (see [Graceful Shutdown](graceful_shutdown.md)).

## 5. Caching Dependencies

Optimize build times by leveraging Docker layer caching for Go modules. Copy `go.mod` and `go.sum` and run `go mod download` *before* copying the rest of the source code.

## 6. Example Dockerfile

```yaml
# -- Stage 1: Builder --
FROM golang:1.26-alpine AS builder

WORKDIR /app

# Copy dependency files and download (caches these layers)
COPY go.mod go.sum ./
RUN go mod download

# Copy the rest of the source code
COPY . .

# Build a statically linked binary
# CGO_ENABLED=0 is required to run on scratch/alpine
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 \
    go build -ldflags="-s -w" -o /bin/server ./cmd/api/main.go

# -- Stage 2: Final Image --
FROM alpine:latest  # Or use gcr.io/distroless/static-debian12

# Create a non-root user
RUN addgroup -S appgroup && adduser -S appuser -G appgroup

WORKDIR /app

# Copy only the compiled binary from the builder stage
COPY --from=builder /bin/server .

# Use the non-root user
USER appuser

EXPOSE 8080

CMD ["./server"]
```

## 7. Handling Multiple Commands (Multiple Binaries)

use a **single, reusable `Dockerfile`** by leveraging Docker Build Arguments (`ARG`). This keeps your CI/CD pipeline DRY and ensures all binaries are built using the exact same base image and security standards.

**Example of a dynamic Dockerfile:**

```dockerfile
# -- Stage 1: Builder --
FROM golang:1.26-alpine AS builder

# Define which app in the cmd/ directory to build
ARG APP_NAME=api

WORKDIR /app
COPY go.mod go.sum ./
RUN go mod download
COPY . .

# Build the specific app using the ARG
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 \
    go build -ldflags="-s -w" -o /bin/app ./cmd/${APP_NAME}/main.go

# -- Stage 2: Final Image --
FROM alpine:latest

RUN addgroup -S appgroup && adduser -S appuser -G appgroup
WORKDIR /app

# The binary is always named "app" in the final stage, regardless of APP_NAME
COPY --from=builder /bin/app .

USER appuser
CMD ["./app"]
```

You can then build different images by passing the `--build-arg` flag:

```bash
# Build the API server
docker build --build-arg APP_NAME=api -t my-api:latest .

# Build the Background Worker
docker build --build-arg APP_NAME=worker -t my-worker:latest .
```
