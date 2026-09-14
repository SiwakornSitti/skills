# Runtime image

- Prefer a small distroless runtime image; choose Alpine only when shell or
  package tooling is required at runtime.
- For a static distroless runtime whose dependencies support it, use
  `CGO_ENABLED=0`, copy only the binary, and run as `nonroot:nonroot`. Do not
  force static builds when the service requires CGO or libc.
- Set an explicit `WORKDIR` and run every runtime stage as a non-root user
  unless the service has a documented need for root privileges. Create the
  user in Alpine or another custom runtime image before switching with `USER`.
- Keep the Go binary as PID 1 with exec-form `ENTRYPOINT`. When child reaping
  is required, prefer runtime init support such as `docker run --init` or
  Compose `init: true` over embedding an init binary.

```yaml
services:
  server:
    build:
      target: server
    init: true # Docker supplies Tini as PID 1.
```

```dockerfile
WORKDIR /app
USER nonroot:nonroot
ENTRYPOINT ["/server"] # Exec form: Go receives SIGTERM directly.
```
