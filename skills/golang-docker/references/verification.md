# Verification

- Validate Dockerfile or Compose edits with `docker compose config` and a
  build of each changed target.
- Run `docker build --check` (or `docker buildx build --check`) for each
  changed Dockerfile and target. If checks are enforced as errors, pin the
  Dockerfile syntax version.
- For release images, publish BuildKit SBOM and provenance attestations, for
  example with `docker buildx build --sbom=true --provenance=mode=max`.
- Keep health and readiness checks in Compose or deployment configuration,
  where they can match the service contract; do not prescribe them in the
  Dockerfile.
- Do not claim an image-size improvement without comparing image sizes before
  and after the change.
