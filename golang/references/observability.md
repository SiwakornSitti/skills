# Observability (OpenTelemetry)

The project uses OpenTelemetry (OTel) for standardized observability, covering distributed tracing, metrics, and logs.

## 1. Principles

- **Vendor Neutrality:** Use OpenTelemetry APIs and SDKs to avoid vendor lock-in.
- **Context Propagation:** Ensure the `context.Context` is passed through all layers (handler -> service -> repository) to maintain trace continuity.
- **Automatic Instrumentation:** Leverage OTel's automatic instrumentation where possible (e.g., for HTTP clients/servers and database drivers).

## 2. Distributed Tracing

- **Trace ID:** Every request should be assigned a unique Trace ID at the entry point (handler).
- **Spans:** Create meaningful spans for significant operations, especially cross-service calls and database queries.
- **Attributes:** Add relevant metadata to spans (e.g., user ID, resource ID) to facilitate debugging, but avoid sensitive data (PII).

## 3. Metrics

- **Golden Signals:** Track Latency, Traffic, Errors, and Saturation (LETS).
- **Standard Metrics:** Use standard OpenTelemetry metrics for system-level monitoring (e.g., CPU, memory, Go runtime metrics).
- **Custom Metrics:** Define custom business metrics (e.g., number of accounts created) where relevant.

## 4. Logging with OTel

- **Correlation:** Logs must include the `trace_id` and `span_id` to correlate them with specific traces.
- **Structured Logs:** All logs must be structured (JSON format) to be easily searchable in observability platforms.
- **Data Redaction:** **Must** redact or mask PII (Personally Identifiable Information) and sensitive data before logging or adding as span attributes.
  - *PII Examples:* Full names, email addresses, phone numbers, physical addresses, national ID numbers (e.g., SSN, Thai ID), and birth dates.
  - *Sensitive Data:* Passwords, authentication tokens, and full credit card numbers.

## 5. Implementation in `/internal`

- Infrastructure for initializing the OpenTelemetry SDK (exporters, samplers) should be placed in a shared package within `/internal`.
- Middleware for HTTP/gRPC tracing should be applied at the handler level.
