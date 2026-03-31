# Web Server Configuration

This document outlines the operational requirements for the HTTP server.

## 1. Server Initialization & Validation

- **Fail Fast:** The application **must** perform a one-time validation of all critical dependencies (e.g., database connections, cache clients, environment variables) during startup (`main.go`). If a critical dependency is misconfigured or unavailable at boot, the application should log a fatal error and exit immediately (`os.Exit(1)`). Do not start the HTTP server if the application cannot function.

## 2. Server and Transport

- **HTTP/2 Cleartext (h2c):** The server **must** support HTTP/2 cleartext (`h2c`). This allows for high-performance, multiplexed communication without requiring TLS encryption in internal or proxied environments (e.g., behind a load balancer, API Gateway, or within a service mesh).
- **Web Framework Choice:**
  - **Preferred:** Standard library `net/http` enhanced with lightweight routers like `go-chi/chi` or `gorilla/mux`.
  - **Avoid `gofiber/fiber`:** Do not use `Fiber` for core business APIs. `Fiber` is built on `fasthttp`, which does not support HTTP/2 and deviates significantly from standard Go `net/http` idioms, making it harder to integrate with standard middleware, OpenTelemetry, and `testcontainers`.
- **Timeouts:** Ensure appropriate `ReadTimeout`, `WriteTimeout`, and `IdleTimeout` are configured on the `http.Server` struct to prevent resource exhaustion and slow-loris attacks.
- **Compression (Brotli/zstd/Gzip):** The server **must** support response compression to reduce payload sizes and improve latency.
  - **Preferred:** Brotli (`br`) or Zstandard (`zstd`) for modern, high-performance compression ratios.
  - **Minimum Requirement:** Gzip (`gzip`) must be supported as a fallback for older clients.
  - *Implementation Suggestion:* Use established middleware like `github.com/go-chi/render` or `github.com/klauspost/compress` (which supports zstd and brotli natively in Go). Always rely on the client's `Accept-Encoding` header to negotiate the correct algorithm.

## 2. Health Checks

To allow orchestrators (like Kubernetes or Docker Swarm) to properly route traffic and restart unhealthy containers, the server **must** implement explicit health check endpoints:

- **Liveness Probe (e.g., `/health/live`):** Should be a simple endpoint that returns `200 OK` indicating the HTTP server is running and hasn't deadlocked. It should **not** check external dependencies.
- **Readiness Probe (e.g., `/health/ready`):** Should check the status of essential external dependencies (e.g., Database, Redis). If any dependency is unreachable, it should return a `503 Service Unavailable` so the orchestrator stops sending traffic to this specific instance.

## 3. Graceful Shutdown

To ensure zero downtime during deployments, the server must support graceful shutdown.

- **Signal Handling:** Applications should listen for `SIGINT` (Ctrl+C) and `SIGTERM` (Docker/Kubernetes termination signal) using `os/signal`.
- **Docker Compatibility:** A compiled Go binary running as PID 1 in a container will natively and correctly receive these OS signals (no `tini` wrapper required).
- **Shutdown Sequence:** Upon receiving a termination signal, the application must:
    1. Stop accepting new connections (`server.Shutdown(ctx)`).
    2. Wait for in-flight requests to complete (within a reasonable context timeout, e.g., 5-10 seconds).
    3. Close persistent connections gracefully (e.g., Database pools, Redis connections).
    4. Flush any pending logs or telemetry data.
    5. Exit the process with status code `0`.
