# Dependencies and supply chain

- Review direct and indirect dependencies through `go.mod` and `go.sum`.
- Run `go mod verify` and the repository's vulnerability scanner in CI.
- Review dependency release notes and the complete module diff before
  accepting an upgrade, especially a major version.
- Remove unused dependencies after migration and verify that the resulting
  graph is intentional.
