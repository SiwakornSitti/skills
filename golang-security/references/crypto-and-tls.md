# Cryptography and TLS

- Prefer the Go standard library for TLS, cryptography, URL parsing, and path
  handling.
- Do not invent cryptographic algorithms, key derivation, certificate
  validation, or token verification.
- Keep algorithm selection, encryption, hashing, password verification, and
  key rotation in `golang-crypto`.
