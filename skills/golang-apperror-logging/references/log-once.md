# Log once

> **Log at the boundary. Wrap everywhere else.**

Logging an error at every call site produces noisy log floods, wastes I/O, and obscures the root cause. Each failure should generate **exactly one** structured log entry at the ingress boundary.

| Layer | Responsibility | Logging Allowed? |
| :--- | :--- | :--- |
| **Outbound Adapter** (`outbound/repository/`, `client/`) | Map to domain errors or return raw error | **NO** — never log |
| **Service Layer** (`service/`) | Enforce business rules, wrap error: `fmt.Errorf("...: %w", err)` | **NO** — never log |
| **Use Case Layer** (`usecase/`) | Orchestrate workflows, wrap error: `fmt.Errorf("...: %w", err)` | **NO** — never log |
| **Inbound Adapter** (`inbound/http/`, `inbound/consumer/`) | Extract context, write HTTP error / ACK/NACK message | **YES** — log once |
