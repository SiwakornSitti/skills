# Domain errors

Model expected business outcomes as context-local domain errors. Define stable
sentinel errors for outcomes callers must branch on, such as not found,
duplicate, or invalid state. Do not branch on error text.

Use standard Go errors in the domain. Keep infrastructure-specific errors out
of domain packages; adapters translate them at their boundary. Add a sentinel
only when callers must branch on that outcome; do not build a global error
catalog.

Recommended baseline:

```go
var (
	ErrNotFound      = errors.New("account not found")
	ErrAlreadyExists = errors.New("account already exists")
	ErrInvalidState  = errors.New("account is in an invalid state")
)
```

Use a typed error only when callers need structured, safe details:

```go
type ValidationError struct {
	Field  string
	Reason string
}

func (e *ValidationError) Error() string {
	return "invalid " + e.Field + ": " + e.Reason
}
```

Keep `Field` and `Reason` safe for logs and boundary responses.
