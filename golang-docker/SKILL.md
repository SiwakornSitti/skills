---
name: golang-docker
description: Optimize Dockerfiles for this Go service, including multi-stage builds, dependency caching, static binaries, minimal runtime images, and named server or consumer targets.
license: MIT
compatibility: Requires Docker and this repository's Go modules.
metadata:
  version: "1.0"
  tags: [go, docker, containers, build]
---

# Go Multi-Stage Container Images

Read the topic reference that matches the task:

- [build-and-cache.md](references/build-and-cache.md) — source inspection, multi-stage builds, dependency caching, and targets.
- [runtime-image.md](references/runtime-image.md) — runtime base images, CGO, PID 1, and process lifecycle.
- [security-and-secrets.md](references/security-and-secrets.md) — image pinning, secrets, runtime contents, and build context.
- [verification.md](references/verification.md) — Compose validation, target builds, health checks, and image-size claims.

Completion check: read every reference matching the change and apply its implementation and verification requirements.

## Related skills

- [golang-security](../golang-security/SKILL.md)
- [golang-config-secrets](../golang-config-secrets/SKILL.md)
- [golang-modernize](../golang-modernize/SKILL.md)
