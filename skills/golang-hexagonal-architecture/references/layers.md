# Layers

| Layer | Owns | Depends on |
| --- | --- | --- |
| `domain/` | Entities, ports, business errors | Standard library only where possible |
| `service/` | One context’s business rules and invariants | Domain repositories and Unit of Work ports |
| `usecase/` | Optional cross-context orchestration | Domain services and other domain contracts |
| `inbound/http/`, `inbound/consumer/` | Inbound protocol translation | Domain service or use-case ports |
| `outbound/repository/`, `outbound/uow/`, and external clients | Persistence, cache, transaction, and protocol translation | Domain ports and infrastructure libraries |

- Inbound ports describe operations callers can trigger; outbound ports describe dependencies the domain requires.
- Keep `usecase/` only when orchestration adds a real boundary; single-context operations can call the service directly.
- Keep Unit of Work lifecycle in `service/` by default. A `usecase/` may own one only for multi-repository work within the same bounded context when no service owns that transaction; cross-context usecases keep transactions local to each context.
- Adapters map transport and storage concerns. Business validation and calculations stay in the owning service/domain.
- Keep one domain package, but split a large domain file into cohesive files for entities, errors, commands/queries, and ports; avoid one file or nested package for every trivial declaration.
- Use narrow interfaces at the consuming boundary and expose domain-owned contracts rather than concrete implementations.
- A repository decorator may compose database and cache adapters, while the service depends only on the domain repository port.
