# Tags and structs

Use `github.com/go-playground/validator/v10` for structural rules on Go structs. Decode input separately, then call `Struct`; keep authorization, business invariants, and database constraints outside validator tags.

- Prefer built-in tags such as `required`, `email`, `min`, `max`, `gte`, `lte`, and `oneof`.
- Use `omitempty` only for optional fields; it skips the remaining tags when the value is empty.
- Use `dive` to validate every element of a slice, array, or map.
- Use `WithRequiredStructEnabled` when required validation must apply to non-pointer nested structs.

## Example

```go
type LineItem struct {
    SKU string `validate:"required"`
}

type CreateOrderRequest struct {
    Email string     `validate:"required,email"`
    Items []LineItem `validate:"required,min=1,dive"`
}

validate := validator.New(validator.WithRequiredStructEnabled())
if err := validate.Struct(request); err != nil {
    return err
}
```
