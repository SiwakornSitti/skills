# Kubernetes Readiness

This document outlines the requirements for ensuring that Go applications in this project are ready to run reliably within a Kubernetes environment.

## 1. Health Checks (Probes)

Every application serving traffic or long-running workers **must** expose HTTP endpoints to allow Kubernetes to monitor its health and routing status.

- **Liveness Probe (`/live` or `/healthz`):**
  - **Purpose:** Answers "Is the application running?"
  - **Implementation:** Should return a `200 OK` almost instantly if the basic HTTP server is up and the main goroutine is functioning. It should **not** check external dependencies (like databases). If this fails, Kubernetes will restart the pod.
- **Readiness Probe (`/ready` or `/readyz`):**
  - **Purpose:** Answers "Is the application ready to accept traffic?"
  - **Implementation:** Should return `200 OK` only if the application has established necessary connections (e.g., successful Ping to PostgreSQL or Redis). If this fails, Kubernetes will stop sending network traffic to the pod but will *not* restart it.

## 2. Graceful Shutdown

Kubernetes routinely stops pods (during deployments, scaling down, or node evictions). Applications must handle this cleanly to avoid dropping active requests or leaving data in an inconsistent state.

- **Listen for `SIGTERM`:** The application must intercept `syscall.SIGTERM` (sent by Kubernetes) and `syscall.SIGINT` (Ctrl+C during local dev).
- **Stop Accepting Traffic:** Upon receiving the signal, immediately stop accepting new HTTP requests or pulling new jobs from queues.
- **Finish Active Work:** Use `http.Server.Shutdown(ctx)` or worker `WaitGroups` to allow currently executing requests or jobs to finish before the program exits.
- **Close Connections:** Safely close database connections (`db.Close()`) and flush logs or metrics before exiting.
- **Max Timeout:** Always wrap the shutdown logic in a `context.WithTimeout` (e.g., 15-30 seconds). If the timeout is reached before shutdown is clean, force exit to prevent the pod from hanging indefinitely, as Kubernetes will aggressively send a `SIGKILL` after the `terminationGracePeriodSeconds` (default 30s).

## 3. Configuration via Environment Variables

Following the Twelve-Factor App methodology:

- All configuration (database URLs, feature flags, secret keys) **must** be read from environment variables.
- Kubernetes ConfigMaps and Secrets will be used to inject these values into the pods.
- Never hardcode configuration files inside the Docker image.

## 4. Resource Limits

Applications should be written with CPU and memory awareness, as Kubernetes enforces limits.

- **`GOMAXPROCS`:** As of Go 1.25, the Go runtime natively detects and respects Linux container CPU quotas. The runtime automatically configures `GOMAXPROCS` to match the restricted limits, so third-party libraries like `go.uber.org/automaxprocs` are **no longer needed**.
- **Memory Limits:** Ensure large datasets are processed via streaming or pagination rather than loading entirely into memory to prevent the pod from being OOMKilled (Out Of Memory).

## 5. Statelessness

- Applications **must** be stateless.
- Do not rely on local file systems or in-memory caches for data that needs to persist across requests or pod restarts.
- Store state in databases (PostgreSQL) or distributed caches (Redis), and write files to blob storage (AWS S3, GCS) instead of the local container filesystem.
