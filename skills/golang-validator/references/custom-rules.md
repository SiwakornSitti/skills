# Custom rules

Use a custom validator only when the package's built-in tags cannot express a reusable structural rule. Register it during startup, before concurrent use, and keep the callback free of network, database, and authorization lookups.

- Use `RegisterValidation` for a named field rule.
- Use `RegisterAlias` when several fields share the same tag composition.
- Return `false` for invalid input; map the resulting tag to the service's stable error code.

## Example

```go
validate := validator.New()
err := validate.RegisterValidation("sku", func(fl validator.FieldLevel) bool {
    value := fl.Field().String()
    return len(value) >= 3 && strings.HasPrefix(value, "SKU-")
})
if err != nil {
    return err
}

type AddItemRequest struct {
    SKU string `validate:"required,sku"`
}
```
