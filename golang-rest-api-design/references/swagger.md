# Swagger

- Annotate every public handler with summary, tags, path or query parameters,
  request body, success response, expected error responses, and the route.
- Keep Swagger types aligned with actual response DTOs; annotations do not
  replace handler tests.
- Defer generation and generated-file checks to `golang-swagger`. Run
  `make gen-docs` after annotation changes and inspect the generated diff.
  Never hand-edit generated Swagger files.
