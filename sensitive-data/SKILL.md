---
name: sensitive-data
description: Design handling for PII, financial or health data, tokens, credentials, private keys, redaction, minimization, retention, and safe fixtures. Trigger when sensitive values appear in code, files, logs, tests, diagnostics, or user-provided prompts.
license: MIT
metadata:
  version: "1.0"
  tags: [sensitive-data, pii, redaction]
---

# Sensitive Data

Use this skill when code reads, stores, transforms, logs, transmits, or tests sensitive data such as PII, financial or health data, credentials, tokens, private keys, or identifiers. Application-handling guidance only; legal and jurisdiction-specific compliance requirements need separate review.

## Immediate secret-exposure rule

If a prompt, tool output, file, or log contains a private key, password, token, credential, or other raw secret:

- Treat it as compromised. Never repeat, quote, save, patch, log, commit, or send the raw value.
- Do not ask the user to paste it again. Tell the user to revoke or rotate it and use a secure file, secret manager, or environment injection they control.
- Continue only with placeholders or metadata such as key type and file path; do not test authentication with the exposed value.

Read the matching topic reference:

- [classification-pii.md](references/classification-pii.md) — classify, minimize, validate, authorize, and serialize PII or sensitive JSON objects.
- [lifecycle-controls.md](references/lifecycle-controls.md) — protect data in APIs, storage, caches, queues, exports, backups, and deletion workflows.
- [redaction-telemetry.md](references/redaction-telemetry.md) — redact logs, errors, metrics, traces, fixtures, and diagnostics; verify safe output.

Completion check: read every reference matching the change and apply its relevant controls.

## Related skills

- [software-principles](../software-principles/SKILL.md) — apply minimization, least privilege, fail-closed, and defense-in-depth decisions.
- [golang-observability](../golang-observability/SKILL.md) — implement bounded logs, metrics, and traces.
- [golang-crypto](../golang-crypto/SKILL.md) — protect data with cryptographic controls.
