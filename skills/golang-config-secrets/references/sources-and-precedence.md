# Sources and precedence

- Treat the process environment as the runtime source. Support `.env` only for
  local tooling or Compose.
- Use this precedence: process environment, local `.env`, then safe non-secret
  defaults.
- Commit `.env.example` with names and safe placeholders. Ignore `.env` and
  never commit real credentials.
- Use an existing `.env` loader only when the application must parse the file;
  otherwise let the platform load it and read values with `os.LookupEnv`.
