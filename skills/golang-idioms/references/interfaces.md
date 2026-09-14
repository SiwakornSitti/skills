# Interfaces

## Accept Interfaces, Return Structs

- Constructors and functions accept domain port interfaces, keeping callers loosely coupled.
- Constructors return interface types for domain ports or unexported struct pointers for internal adapters:

```go
func New(repo domain.Repository, uowFactory domain.UnitOfWorkFactory) domain.Service {
    return &service{
        repo:       repo,
        uowFactory: uowFactory,
    }
}
```

## Keep Interfaces Small and Role-Based

Define interfaces where they are consumed or as focused domain ports. Avoid large 20-method monolithic interfaces.
