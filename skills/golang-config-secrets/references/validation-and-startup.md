# Validation and startup

- Fail startup for missing or invalid required configuration. Defaults are for
  safe non-sensitive local behavior only.
- Validate URLs, durations, ports, sizes, and enum values before constructing
  clients.
- Identify the missing or invalid key in an error without including its value.

```go
value, ok := os.LookupEnv("SERVICE_URL")
if !ok || value == "" {
    return fmt.Errorf("SERVICE_URL is required")
}
```
