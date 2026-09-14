# Source modernization

- Read the affected package and every caller before changing an API. Keep the
  smallest compatible change that removes the legacy form.
- Prefer current language and standard-library idioms available through the
  declared Go version. Keep the older form when the replacement does not
  compile, changes behavior, or does not fit the boundary.
- Preview automatic changes with `go fix -diff ./...`. Apply only intended
  fixes, then review the diff before formatting and testing.
- Change one concern at a time: a language idiom, one standard-library
  migration, or one dependency.
- Preserve error behavior, cancellation, ownership, public contracts, and
  persistence or wire formats. Do not use modernization as a reason to add a
  speculative abstraction.
