# Security and secrets

- Pin production base images by immutable digest for reproducible builds;
  tags are acceptable for local-development examples.
- Keep build metadata as an `ARG`; never put secrets in Docker `ARG` or `ENV`.
  Use BuildKit secret mounts or external authenticated dependency
  configuration when private modules are required.
- Do not put build tools, source, package managers, or secrets in the runtime
  image.
- Keep `.dockerignore` aligned with the build context so local binaries,
  credentials, VCS data, and editor files do not invalidate layers or enter
  the build context.
