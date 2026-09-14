# Lifecycle and tests

Create and configure one `validator.Validate` instance during application startup, inject it into handlers or services, then reuse it. Register aliases, custom rules, and tag-name functions before request handling starts; do not create or mutate the singleton per request while it is shared by concurrent callers.

- Test every built-in or custom tag used by the contract, including missing, malformed, boundary, and valid values.
- Test nested collection rules with `dive`.
- Test the mapping from `ValidationErrors` to public field names and stable codes.

## Example

```go
func buildValidator() *validator.Validate {
    validate := validator.New(validator.WithRequiredStructEnabled())
    // Register aliases, custom rules, and tag-name functions here.
    return validate
}

func startApplication() {
    validate := buildValidator() // once at startup
    handler := NewHandler(validate)
    runServer(handler)
}

func TestCreateOrderValidation(t *testing.T) {
    validate := buildValidator()

    if err := validate.Struct(CreateOrderRequest{
        Email: "user@example.invalid",
        Items: []LineItem{{SKU: "SKU-001"}},
    }); err != nil {
        t.Fatal(err)
    }

    if err := validate.Struct(CreateOrderRequest{Email: "bad", Items: nil}); err == nil {
        t.Fatal("expected validation errors")
    }
}
```
