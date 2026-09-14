# Wiring

**Composition Root**: the place where concrete implementations are assembled. A context module composes one bounded context; `cmd/*` composes the application from context modules and shared infrastructure.

- Keep constructors for repositories, services, handlers, consumers, and relays at a composition boundary.
- A context module may expose domain interfaces and inbound adapter entry points while keeping implementation details private.
- Module constructors receive narrow application ports, never another context's concrete `Module`; the composition root supplies the adapter.
- Application entry points load configuration, create shared infrastructure, construct modules, and start the selected runtime.
- Do not read environment variables or construct infrastructure inside domain, service, handler, or repository code.
- Keep module wiring explicit; add a dependency only when the owning module’s contract requires it.

## Modular-monolith shape

A bounded-context module may compose the complete local graph:

```text
module.go
  outbound/repository/db + outbound/repository/cache
  outbound/uow
  outbound/<dependency> adapters for cross-context translation
  service
  usecase
  inbound/http + inbound/consumer
  outbox store + relay
```

Keep `module.go` focused on constructor calls and dependency assembly. A tiny
pass-through adapter may stay there; move non-trivial cross-context translation
to `outbound/<dependency>/`. Event-to-command mapping and workflow policy belong
in `usecase/`. Repository, cache, database, and transaction implementations
belong in `outbound/`.

The user context demonstrates this layout with
`outbound/account/account_reader.go` and
`outbound/notification/notification_writer.go`.
