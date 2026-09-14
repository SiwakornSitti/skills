## Verification

- Test known vectors, round trips, tamper detection, wrong-key rejection, nonce uniqueness, malformed envelopes, and key rotation.
- Use `crypto/rand` for keys, nonces, salts, and tokens. Never use `math/rand` for security values.
- Do not use production keys in fixtures. Return safe external errors without revealing plaintext or key details.

Run focused security tests and `go test ./...` after changing cryptographic formats or key handling.
