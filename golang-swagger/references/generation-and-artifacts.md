# Generation and Artifacts

## Source and command

Handler annotations are the source. `docs/docs.go` and the generated Swagger
specification are artifacts; never hand-edit them.

Run the repository target after annotation changes:

```bash
make gen-docs
```

The target requires the repository's `check-tools` and runs:

```bash
swag init -g cmd/server/main.go --outputTypes go,json
```

Use `make gen-docs` for the normal workflow. Use the exact `swag init` command
only to diagnose a tooling or target failure. `make gen` also regenerates mocks
and is broader than a Swagger-only change.

## Tool version

Keep the generator compatible with the version in `go.mod` (`swag` is currently
pinned there). The installation target uses `swag@latest`, so check `swag
--version` when generated output changes unexpectedly. Do not accept a large
generated diff caused only by an unexplained generator upgrade.

## Generated files

Review the actual files produced in `docs/`. This repository tracks
`docs/docs.go` and `docs/swagger.yaml`; do not assume a JSON file is tracked just
because the command requests JSON output. Inspect `git status` and the generated
diff rather than creating or editing an artifact by hand.

If a registered and annotated route is absent from generated output, check the
generator version, entrypoint, output types, package parsing, and annotation
syntax before changing runtime code.
