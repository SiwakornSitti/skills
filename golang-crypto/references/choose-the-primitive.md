## Choose the primitive

| Need | Use | Do not use |
| --- | --- | --- |
| Confidentiality + integrity | AEAD such as AES-GCM | AES-CBC/ECB without a separate, correct MAC |
| Public-data fingerprint | SHA-256 or SHA-512 | Encryption or HMAC with a public key |
| Authenticity with shared secret | HMAC-SHA-256 | Plain hash of `secret + message` |
| Password verification | Argon2id or bcrypt with a unique salt | SHA-256, encryption, or reversible storage |
