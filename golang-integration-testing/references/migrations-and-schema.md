# Migrations and schema

- Apply sorted repository migrations to the test database; do not maintain hand-written test tables that drift from production.
- Fail setup on migration read or execution errors.
- Use the same schema constraints, indexes, and transaction behavior as the target environment.
- Keep migration parsing/tool directives consistent with the repository migration format.
