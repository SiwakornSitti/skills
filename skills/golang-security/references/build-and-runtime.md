# Build and runtime

- Build with least privilege: use a static minimal runtime where compatible
  and run as a non-root user.
- Keep compilers, package managers, credentials, source, and build secrets out
  of runtime images.
- Keep image hardening and secret mounts aligned with `golang-docker`; this
  skill defines the security outcome, not a second Docker recipe.
