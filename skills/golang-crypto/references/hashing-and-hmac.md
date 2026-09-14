## Hashing and HMAC

- Hash canonical bytes. Include field boundaries and a stable representation before hashing; avoid ambiguous concatenation.
- Use HMAC for authenticity with a shared secret. Compare tags with `hmac.Equal`, never `==` or `bytes.Equal`.

```go
sum := sha256.Sum256(canonicalBytes)
fingerprint := hex.EncodeToString(sum[:])

mac := hmac.New(sha256.New, secretKey)
_, _ = mac.Write(message)
valid := hmac.Equal(mac.Sum(nil), receivedTag)
```
