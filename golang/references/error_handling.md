# Error Handling and Logging

## 1. Internal Error Handling

- **Handle Once:** An error should be handled only once. Logging an error is a form of handling.
- **Don't Double Log:** If you return an error to a caller, **do not log it**. Let the final caller (usually the `handler` layer) decide whether to log it or return a specific HTTP status code.
- **Wrap for Context:** Use `fmt.Errorf` with the `%w` verb to wrap errors and provide additional context as they bubble up the stack. This helps in tracing where the error originated.
- **Consistent Structure:** Log errors with enough context (e.g., request ID, user ID) to make them actionable, but avoid logging sensitive information (PII).

## 2. API Error Responses

When returning errors to the client, the response body must follow a strict JSON structure.

### 4xx Client Errors

Must include a machine-readable `code` (e.g., `INVALID_INPUT`). If an error has multiple causes (e.g., multiple validation failures in one request), provide them all at once in a `details` or `errors` array.

- **Flexible but Brief Details:** The `details` array can contain any relevant fields (e.g., `field`, `value`, `reason`) needed to explain the error. Keep the information brief and actionable for the client.

*Example for Multiple Causes:*

```json
{
  "code": "INVALID_INPUT",
  "details": [
    {
      "field": "email",
      "code": "INVALID_FORMAT"
    },
    {
      "field": "age",
      "code": "TOO_YOUNG"
    }
  ]
}
```

### 5xx Server Errors

Must **NOT** include any message or explanation of what went wrong. Provide only a generic indicator (e.g., a static reference ID or error code) without any descriptive text.

**CRITICAL:** This ensures no internal implementation details, stack traces, or clues are leaked to the client that could be used for exploitation.

*Example 5xx Response:*

```json
{
  "code": "INTERNAL_SERVER_ERROR",
  "reference_id": "tr-1234abc5678"
}
```
