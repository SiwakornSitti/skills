## Passwords and keys

- Password KDF parameters must be tunable and stored with the hash; verify with the KDF's constant-time verifier.
- Keep key material in a secret manager or KMS. Use `KeyID` or `KeyVersion` to identify it; that identifier may be UUIDv7 but is never the secret key. Decrypt with retained old versions during rotation, and re-encrypt on successful access or a controlled migration.
- Never log, commit, embed, expose in URLs, or place keys in Docker build arguments.
