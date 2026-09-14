# Functional Core, Imperative Shell

Keep business decisions in small pure functions. Put effects such as clocks,
randomness, network calls, database writes, and message publication in the
imperative shell that gathers inputs and applies the result.

## Functional core

The core should be deterministic: the same input produces the same output and
does not mutate external state.

- Accept time, randomness, and external state as values or explicit arguments.
- Return a decision, value, or domain error rather than performing I/O.
- Keep validation and business invariants near the decision they protect.
- Prefer immutable-by-convention results or clear ownership of mutations.

Pure does not mean every function must be tiny. Keep a cohesive calculation in
the core when it can be tested without a database, network, process, or clock.

## Imperative shell

The shell owns orchestration and effects:

- Load state and external inputs.
- Obtain the current time or random value.
- Call the pure decision logic.
- Persist results, publish messages, and translate operational errors.
- Apply transaction and retry boundaries appropriate to the side effects.

Keep the shell thin, but do not hide failure handling or consistency rules in a
generic helper.

## Example

The core decides whether an account may be debited; the shell loads the account
and saves the result:

```text
debit(account, amount):                         # functional core
    require amount > 0
    require account.balance >= amount
    return account with balance = account.balance - amount

debitAccount(id, amount):                       # imperative shell
    account = repository.load(id)
    updated = debit(account, amount)
    repository.save(id, updated)
```

Test `debit` with a table of inputs. Test the shell separately for repository
calls, transaction behavior, and error propagation.

## Boundary test

If a business rule cannot be tested without starting infrastructure, identify
which dependency is leaking into the core. Move the effect outward or pass its
result inward as data. Keep integration tests for the shell and adapters where
the real effect is required.
