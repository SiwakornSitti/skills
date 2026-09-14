# Design choices

- Start from the concrete coupling, variation, or lifecycle problem.
- Prefer direct functions, structs, standard-library features, and existing repository patterns before introducing a named pattern.
- Add a pattern only when it removes real duplication or isolates an expected variation.
- State the problem a pattern solves and why simpler code is insufficient.
- Keep interfaces at the consumer boundary and preserve the repository's hexagonal architecture.
- For implementation changes, leave one focused test or runnable check for non-trivial behavior.
