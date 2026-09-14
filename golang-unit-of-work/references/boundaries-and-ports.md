# Boundaries and Ports

## Scope

Use a Unit of Work when one operation must atomically write through multiple
repositories owned by the same bounded context. The service layer owns
`Begin`, `Commit`, and `Rollback` by default. A usecase may own that lifecycle
only when it coordinates multiple repositories in the same bounded context
and no service owns the transaction; handlers and repositories do not.

For a single-repository operation, use the normal repository directly. Existing
code may still contain broader UoW usage; preserve unrelated behavior during a
focused change and migrate those exceptions deliberately.

A UoW never spans bounded contexts, databases, remote calls, or message
delivery. Each context commits its own local work. Use an outbox or workflow for
durable cross-context coordination.

## Domain port

Define the port in the bounded context's `domain` package. Keep driver pools,
transaction handles, query builders, and database infrastructure out of domain
and service code. Expose explicit typed accessors for the repositories owned by
that context. Avoid a generic repository registry or dynamic lookup.

```go
package domain

import "context"

type UnitOfWork interface {
	Accounts() Repository
	Commit(context.Context) error
	Rollback(context.Context) error
}

type UnitOfWorkFactory interface {
	Begin(context.Context) (UnitOfWork, error)
}
```

Add an accessor only for a repository that participates in the same local
atomic operation. If the operation also records an event, expose a typed
`Outbox() outbox.Store` accessor backed by the same transaction.

## Database adapter

The database adapter owns the driver transaction and constructs
transaction-bound repositories. Repository constructors should accept the
narrow query interface already used by the repository package so both the
normal database handle and the driver's transaction handle can be supplied.

```go
type unitOfWork struct {
	tx   transaction
	repo domain.Repository
}

func (u *unitOfWork) Accounts() domain.Repository { return u.repo }

func (u *unitOfWork) Commit(ctx context.Context) error {
	return u.tx.Commit(ctx)
}

func (u *unitOfWork) Rollback(ctx context.Context) error {
	return u.tx.Rollback(ctx)
}

type transaction interface {
	Commit(context.Context) error
	Rollback(context.Context) error
}
```

Start the driver's transaction with its default options. Introduce driver
specific options only for a demonstrated isolation, read-only, or workload
requirement, and document that reason at the adapter boundary.

Normalize the driver's expected post-commit closed-transaction rollback result
as harmless. Preserve unexpected rollback failures for observation without
replacing the original business or commit error. The normalization mechanism is
driver-specific and belongs in the adapter, not the domain port.
