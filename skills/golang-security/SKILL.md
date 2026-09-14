---
name: golang-security
description: Apply secure defaults to Go code, dependencies, builds, and service boundaries.
license: MIT
compatibility: Requires Go 1.22+.
metadata:
  version: "1.0"
  tags: [go, security, supply-chain, secrets]
---

# Go Security and Supply Chain

Read the reference matching the security concern:

- [trust-boundaries.md](references/trust-boundaries.md) — authentication, authorization, input validation, and bounds.
- [secrets-and-data.md](references/secrets-and-data.md) — secret and sensitive-data handling.
- [crypto-and-tls.md](references/crypto-and-tls.md) — standard-library cryptography, TLS, URLs, and paths.
- [dependencies-and-supply-chain.md](references/dependencies-and-supply-chain.md) — module integrity and vulnerability checks.
- [build-and-runtime.md](references/build-and-runtime.md) — least-privilege builds and runtime images.
- [errors-and-disclosure.md](references/errors-and-disclosure.md) — safe external errors and internal context.
- [verification.md](references/verification.md) — focused security, dependency, and runtime checks.

Completion check: read every reference matching the change and apply its implementation and verification requirements.

## Related skills

- [golang-config-secrets](../golang-config-secrets/SKILL.md)
- [sensitive-data](../sensitive-data/SKILL.md)
- [golang-crypto](../golang-crypto/SKILL.md)
- [golang-docker](../golang-docker/SKILL.md)
- [golang-observability](../golang-observability/SKILL.md)
