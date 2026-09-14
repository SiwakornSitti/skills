# Errors and fields

Handle the package's result types explicitly. `validator.ValidationErrors` represents user input that failed a tag; `validator.InvalidValidationError` represents an invalid value passed to the validator and should be treated as a programming error.

- Convert `ValidationErrors` into the service's stable field-error contract.
- Use `FieldError.Field()` for the Go field or register a tag-name function when the contract needs JSON names.
- Return tags as internal mapping inputs, not raw error text.
- Never include submitted passwords, tokens, card numbers, addresses, or other sensitive values in errors.
- Never log the request, validation object, submitted value, or raw validator error; log only an allowlisted event and stable error code.

## Example

```go
if err := validate.Struct(request); err != nil {
    var invalid *validator.InvalidValidationError
    if errors.As(err, &invalid) {
        return fmt.Errorf("validator received an invalid value: %w", err)
    }

    var failures validator.ValidationErrors
    if errors.As(err, &failures) {
        for _, failure := range failures {
            addFieldError(failure.Field(), failure.Tag())
        }
        return ErrInvalidRequest
    }
    return err
}
```
