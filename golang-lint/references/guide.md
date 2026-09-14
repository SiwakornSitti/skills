# Go lint

Use the repository configuration as the source of truth. It targets Go 1.27,
golangci-lint v2, `depguard`, `misspell`, and the `goimports` formatter.

## Architecture guardrails

`depguard` blocks cross-context imports of another context's `repository`,
`service`, or `inbound` implementation packages.

For a cross-context call:

- define the narrow port in the consuming `usecase/` package;
- keep foreign domain contracts in the module or an
  `outbound/<dependency>/` adapter;
- map foreign entities and commands to caller-owned types at that boundary;
- wire the adapter from `module.go` or `cmd/server/main.go`.

The usecase must not import the other context's implementation or domain
entities. Do not suppress a boundary violation with `//nolint:depguard`.

## Commands

```bash
make lint
make test
make pre-commit
```

For a focused check:

```bash
golangci-lint run ./internal/user/...
```

If tools are missing, use `make install-tools`; the versions are defined in
`Makefile`.
