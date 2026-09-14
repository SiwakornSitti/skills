# Boundaries and mapping

- Keep SQL in the adapter layer. Domain services receive domain values and
  errors, not driver types.
- Read the repository, its domain port, migration, and callers before changing
  a query or persistence mapping.
- Map database rows explicitly into domain values. Keep persistence details out
  of domain ports and use cases.
