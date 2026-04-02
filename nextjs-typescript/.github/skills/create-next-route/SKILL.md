---
name: create-next-route
description: 'Create a Next.js Route Handler (API route) using the App Router. Use for handling GET, POST, PUT, DELETE, and PATCH HTTP requests.'
---

# Create Next.js Route Handler

## When to Use
- Creating backend APIs for the Next.js application
- Handling webhook events
- Proxying external API requests securely

## Procedure
1. Create a `route.ts` file in the appropriate directory under `app/api/` (e.g., `app/api/users/route.ts`).
2. Export async functions named after the HTTP methods (`GET`, `POST`, `PUT`, `DELETE`, `PATCH`).
3. Use `NextResponse` from `next/server` to return JSON responses.
4. Extract path parameters from the second `context` argument.
5. Extract query parameters from the `NextRequest` URL.
6. Handle errors properly with try/catch blocks and return appropriate HTTP status codes.

## Template
Use the [Route Template](./assets/route-template.ts) for boilerplate.