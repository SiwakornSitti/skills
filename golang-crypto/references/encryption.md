## Encryption

- Use `cipher.NewGCM` (or another approved AEAD) with a key held outside application code.
- Generate a fresh random nonce for every `Seal` call; never reuse a nonce with the same key.
- Bind non-secret context such as tenant ID or record type as associated data; `Open` must receive the same bytes.
- Store a version, key ID, nonce, and ciphertext. Reject unknown versions, unknown keys, truncated envelopes, and authentication failures.

```go
block, err := aes.NewCipher(key)
if err != nil { return nil, err }
box, err := cipher.NewGCM(block)
if err != nil { return nil, err }
nonce := make([]byte, box.NonceSize())
if _, err := io.ReadFull(rand.Reader, nonce); err != nil { return nil, err }
sealed := box.Seal(nil, nonce, plaintext, associatedData)
wire := append(nonce, sealed...)
```

On read, split the stored nonce from `wire`, call `box.Open`, and return one generic authentication error to callers.
