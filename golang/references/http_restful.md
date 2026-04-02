# HTTP RESTful API Design

## Contents
- [1. Naming & Methods](#1-naming--methods)
- [2. Query Parameters for GET Requests](#2-query-parameters-for-get-requests)
- [3. Idempotency Keys](#3-idempotency-keys)
- [4. HTTP Status Codes](#4-http-status-codes)
- [5. Response Format](#5-response-format)

## 1. Naming & Methods

- **Resource-Based Naming:** Use plural nouns for resources (e.g., `/users`, `/orders`). Avoid using verbs in URLs (e.g., avoid `/getUsers`).
- **HTTP Methods:**
  - `GET`: Retrieve a resource or a collection of resources. **Must be idempotent and safe** (no side effects).
  - `POST`: Create a new resource. **Must be idempotent** (using Idempotency Keys).
  - `PUT`: Update an existing resource or create it if it doesn't exist (Upsert). **Must be idempotent** (repeating the request yields the same state).
  - `PATCH`: Partially update an existing resource.
  - `DELETE`: Remove a resource. **Must be idempotent**.

## 2. Query Parameters for GET Requests

When fetching collections of resources via `GET`, APIs must support standard query parameters for pagination, filtering, and sorting to ensure performance and usability.

- **Pagination:**
  - `limit`: The maximum number of items to return (e.g., `?limit=50`). Must have a reasonable default and a strict maximum to prevent abuse.
  - `offset`: The number of items to skip before starting to collect the result set (e.g., `?offset=100`). Useful for simple, small datasets.
  - `cursor`: A pointer to a specific item in the dataset, used for highly performant, stable pagination on large datasets (e.g., `?cursor=eyJpZCI6MTIzfQ==`). Preferred over `offset`.
- **Filtering:** Use standard query parameters for exact matches (e.g., `?status=active&role=admin`). For complex filtering, use a specific `filter` parameter or advanced query syntax.
- **Sorting:**
  - `sort`: The field(s) by which to order the results (e.g., `?sort=createdAt`).
  - `direction` (or `order`): The direction of the sort, either `asc` (ascending) or `desc` (descending) (e.g., `?sort=createdAt&direction=desc`). Alternatively, use prefixes like `-createdAt` for descending.

## 3. Idempotency Keys

To ensure `POST` requests are idempotent (e.g., creating a payment or placing an order), the server **must** support and validate an `Idempotency-Key` header.

- This ensures that if a client experiences a network timeout and retries the request, the server does not perform the same action twice (e.g., charging a customer twice).
- Store the key alongside the resource or in a dedicated fast storage (like Redis) with an appropriate TTL to recognize duplicate requests.
- **Response Handling:** If a duplicate request is detected using an existing idempotency key, the server **must** return the exact same HTTP status code and response body as the original successful request (e.g., returning the previously created resource with a `201 Created` or `200 OK`).

## 4. HTTP Status Codes

- **2xx (Success):** Everything worked as expected.
  - `200 OK`: Success (GET, PUT, PATCH).
  - `201 Created`: Success (POST, PUT if new resource created).
  - `204 No Content`: Success (DELETE).

- **4xx (Client Errors):** Problems that the user/client can solve themselves (e.g., bad input, missing authentication).
  - `400 Bad Request`: Validation or client-side error.
  - `401 Unauthorized`: Authentication required (e.g., missing API key).
  - `403 Forbidden`: Authenticated but lack permission (e.g., role-based access).
  - `404 Not Found`: Resource does not exist.
  - `405 Method Not Allowed`: HTTP method is not supported for this URL.
  - `409 Conflict`: Request conflicts with current state, like a duplicate unique field.
  - `422 Unprocessable Entity`: JSON is valid, but content contains semantic errors (e.g., business rule violations).
  - `429 Too Many Requests`: Rate limiting - too many requests in a given timeframe.

- **5xx (Server Errors):** Problems the client cannot solve. **CRITICAL:** Never leak internal implementation details, stack traces, or clues that could be used for exploitation in 5xx responses.
  - `500 Internal Server Error`: General server-side error.

## 5. Response Format

- **JSON First:** Use `application/json` as the default `Content-Type` for both requests and responses.
- **Key Casing:** Use `camelCase` for all JSON keys.
- **Collections & Pagination:** When returning a collection of resources, always wrap the results in a `data` array and include a `meta` object containing the current state of pagination and sorting.
- **Errors:** Standardize error responses by wrapping details in an `error` object. This provides clear, parseable feedback to the client without exposing internal stack traces.

### Examples

**Example Collection Response:**

```json
{
  "data": [
    {
      "id": "123",
      "status": "active",
      "createdAt": "2026-03-30T10:00:00Z"
    },
    {
      "id": "124",
      "status": "active",
      "createdAt": "2026-03-30T09:00:00Z"
    }
  ],
  "meta": {
    "limit": 50,
    "offset": 0,
    "total": 100,
    "nextCursor": "eyJpZCI6MTI0fQ==",
    "prevCursor": null,
    "sort": "createdAt",
    "direction": "desc"
  }
}
```

**Example Error Response:**

```json
{
  "error": {
    "code": "invalid_request",
    "message": "The provided input is invalid.",
    "details": [
      {
        "field": "email",
        "issue": "Must be a valid email address."
      }
    ]
  }
}
```
