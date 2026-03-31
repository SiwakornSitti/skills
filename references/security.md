# Security Guidelines

This document outlines the security best practices for Go application development in this project.

## 1. Input Validation and Sanitization

- **Trust No One:** Treat all data from external sources (HTTP requests, database, environment variables) as untrusted.
- **Whitelist Validation:** Prefer whitelisting allowed characters/formats over blacklisting.
- **Sanitization:** Sanitize input before using it in HTML templates, database queries, or shell commands.

## 2. Authentication and Authorization

- **Authentication Tokens (PASETO/JWT):**
  - **PASETO (Preferred):** Use Platform-Agnostic SEcurity TOkens (PASETO) for new implementations. It provides a more secure-by-default alternative to JWT by avoiding the "alg" header and other common JWT pitfalls.
  - **JWT:** If using JSON Web Tokens (JWT), **must** use asymmetric signing with `ES256` (ECDSA using P-256 and SHA-256) or stronger (e.g., `ES384`, `EdDSA`). Ensure short expiration times (TTL) and proper audience/issuer validation.
- **Secure Password Storage:** **Must** use `argon2id` for password hashing. Avoid using older algorithms like `bcrypt` or `scrypt` for new implementations. Never store passwords in plain text.
- **RBAC:** Implement Role-Based Access Control (RBAC) at the service or handler layer to enforce the principle of least privilege.

## 3. Data Protection

- **Sensitive Data:** Never hardcode secrets (API keys, passwords) in the codebase. Use environment variables or a dedicated secret management service (e.g., HashiCorp Vault, AWS Secrets Manager).
- **Encryption at Rest/Transit:** Ensure sensitive data is encrypted at rest in the database and always use TLS (HTTPS) for data in transit.
- **Logging:** Never log sensitive information such as PII (Personally Identifiable Information), passwords, or full credit card numbers.

## 4. Cryptography

- **Strong Algorithms:** Use standard library `crypto` packages. Avoid outdated/weak algorithms like MD5 or SHA1 for security purposes.
- **Symmetric Encryption:** When encrypting data at rest, **must** use `AES-256-GCM`.
- **Dynamic Nonce:** Always use a unique, cryptographically secure dynamic nonce (Initialization Vector) for every encryption operation. Never reuse a nonce with the same key.
- **Secure Randomness:** Use `crypto/rand` for generating tokens, salts, nonces, or keys. Never use `math/rand` for security-sensitive operations.

## 5. Web Security

- **Security Headers:** The web server **must** configure standard HTTP security headers (e.g., using middleware like `helmet` or `secure`).
  - `X-Content-Type-Options: nosniff` (Prevents MIME-sniffing attacks).
  - `X-Frame-Options: DENY` or `SAMEORIGIN` (Prevents Clickjacking).
  - `Strict-Transport-Security` (HSTS) with a `max-age` of at least 31536000 seconds (1 year) and `includeSubDomains`.
  - `Content-Security-Policy` (CSP) configured as strictly as possible based on the application's needs.
- **CORS:** Implement a strict Cross-Origin Resource Sharing (CORS) policy. Avoid `Access-Control-Allow-Origin: *` in production environments. Explicitly whitelist trusted origin domains.
- **CSRF Protection:** Use CSRF tokens (Synchronizer Token Pattern) for state-changing requests (POST, PUT, DELETE, PATCH) when using Cookie-based sessions.

## 6. Dependency Management

- **No Unmaintained Dependencies:** Do not add third-party libraries (`go.mod` dependencies) that are no longer actively maintained, lack recent commits, or have unresolved critical issues. Always evaluate a library's health before adoption.
- **Vulnerability Scanning:** Regularly run `govulncheck` to identify known vulnerabilities in your dependencies.
- **Keep Updated:** Keep Go and its third-party libraries updated to their latest stable versions.

## 7. Error Handling

- **No Information Leaks:** As defined in [Error Handling](error_handling.md), never leak internal implementation details or stack traces to the client in error responses (especially 5xx).
