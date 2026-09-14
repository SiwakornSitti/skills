# JSON configuration

- Decode optional JSON configuration into a typed struct, overlay typed
  environment values, then validate the merged config. Never rewrite raw JSON
  to inject environment strings.
- Use a typed struct when the JSON shape is known. Use
  `map[string]json.RawMessage` only for genuinely dynamic keys.
- Decode the whole object and reject unknown fields before applying overrides.

```go
type Config struct {
    ServiceURL string `json:"service_url"`
}

dec := json.NewDecoder(configFile)
dec.DisallowUnknownFields()
if err := dec.Decode(&cfg); err != nil {
    return fmt.Errorf("decode config: %w", err)
}
if value, ok := os.LookupEnv("SERVICE_URL"); ok {
    cfg.ServiceURL = value // env overrides JSON
}
```

For a JSON object carried in one environment variable, decode the value
directly:

```go
type Options struct {
    Retries int `json:"retries"`
}

raw, ok := os.LookupEnv("SERVICE_OPTIONS_JSON")
if !ok || raw == "" {
    return fmt.Errorf("SERVICE_OPTIONS_JSON is required")
}
var options Options
dec := json.NewDecoder(strings.NewReader(raw))
dec.DisallowUnknownFields()
if err := dec.Decode(&options); err != nil {
    return fmt.Errorf("decode SERVICE_OPTIONS_JSON: %w", err)
}
```
