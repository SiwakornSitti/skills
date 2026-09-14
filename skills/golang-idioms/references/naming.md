# Naming

- Keep packages short, lowercase, singular where natural; let package names qualify APIs: `account.Account`, not `account.AccountEntity`.
- Avoid stutter at call sites: use `http.Client`, not `http.HTTPClient`; use `config.Parse`, not `config.ParseConfig`.
- Use `New()` for a package's single primary type and `NewTypeName()` when it constructs one of several public types.
- Keep initialisms consistent: `ID`, `URL`, `HTTP`, `JSON`, `API`.
- Name generic identifiers with `ID` (`AccountID`, `KeyID`); use `UUID` only when UUID format is part of the contract. UUIDv7 can be the value behind an `ID`.
- Name functions with concise verbs; use `Is`, `Has`, `Can`, or `Should` for boolean predicates. Avoid `Do`, `Process`, and negative booleans such as `isNotReady`.
- Omit `Get` from ordinary accessors (`Name()`); retain `Get` for application methods that retrieve one known resource.
- Name slices/arrays by element meaning (`accounts`, `days`, `digest`); name maps by relationship (`accountsByID`, `countsByStatus`).
- Name keys for what they identify (`accountID`, `cacheKey`), not generic `key`; use a comparable key struct when identity has multiple fields.
- Name domain events as past-tense facts (`AccountCreated`, `PaymentAuthorized`); use stable type strings such as `account.created`.
- Name event payload fields after domain concepts (`AccountID`, `OccurredAt`); name consumers with action verbs (`HandleAccountCreated`).
- Use CRUD verbs precisely: `Create` new resources, `Get` one known resource, `Find` repository queries, `List` collections, `Update` existing resources, `Delete` removal. Avoid aliases such as `GetAll`, `DoUpdate`, or `Remove` for resource APIs.
- Keep receivers short and consistent: `s` for `service`, `r` for `repository`, `uc` for `useCase`.
- Give `iota` enums an explicit `Unknown` or `Invalid` zero value; reserve real states for later values.
- Use `Err` for sentinel variables and `Error` for error types; keep error text lowercase and without punctuation. Follow [golang-error-handling](../../golang-error-handling/SKILL.md) for error semantics.
- Name tests `Test` plus the subject and use lowercase descriptive subtests such as `"empty input"`.
- Use `With` plus the field for functional options (`WithPort`, `WithLogger`) and `Must` only for deliberately panicking helpers (`MustParse`).
- Use `Get` for one known application resource; use `Find` for repository lookup/query.
- Preserve exported names unless callers and compatibility impact are included in the change.

```go
type Account struct{ ID string } // account.Account, not account.AccountEntity

func (r *repository) FindByID(ctx context.Context, id string) (*Account, error)

func (a Account) IsActive() bool
accountsByID := map[string]Account{}
type AccountKey struct{ TenantID, AccountID string }
var digest [32]byte

type AccountCreated struct {
    AccountID string
    OccurredAt time.Time
}

func (s *service) CreateAccount(ctx context.Context, cmd CreateAccountCommand) (*Account, error)
func (s *service) GetAccount(ctx context.Context, id string) (*Account, error)
func (s *service) ListAccounts(ctx context.Context, q ListQuery) ([]Account, error)
func (s *service) UpdateAccount(ctx context.Context, a Account) error
func (s *service) DeleteAccount(ctx context.Context, id string) error
```
