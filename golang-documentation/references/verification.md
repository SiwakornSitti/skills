# Verification

- Run package examples and documentation tests with the repository’s normal Go test command.
- Run `go doc` or the project’s documentation generator to catch malformed or missing exported documentation.
- Check internal links, code blocks, commands, configuration names, and generated diffs.
- Run the scoped Markdown formatter/linter and `git diff --check`; report unavailable validators instead of widening scope.
