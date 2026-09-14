# Build and cache

Before editing, read `Dockerfile`, `.dockerignore`, `docker-compose.yaml`,
`go.mod`, and the target `cmd/` package.

- Match the builder Go version to `go.mod`.
- Use a distinct builder stage and a minimal runtime stage; copy only the
  built binary into runtime.
- Preserve dependency-cache order: copy `go.mod` and `go.sum`, run `go mod
  download` and `go mod verify`, then copy source.
- When BuildKit is available, optionally use cache mounts for `/go/pkg/mod` and
  `/root/.cache/go-build`. Builds must still work with empty or evicted caches.
- Build only the requested command. Preserve named runtime targets such as
  `server` and `consumer` when Compose selects them.

```dockerfile
RUN --mount=type=cache,target=/go/pkg/mod \
    --mount=type=cache,target=/root/.cache/go-build \
    go build -o /server ./cmd/server
```
