---
name: create-react-query-hook
description: 'Create a custom TanStack Query (React Query) hook for client-side data fetching or mutations in Next.js. Use for optimizing client-side state, caching, and API interactions.'
---

# Create React Query Hook

## When to Use
- Fetching data on the client side in Next.js App Router (inside `"use client"` components).
- Optimizing data fetching with caching, background updates, and stale-time management.
- Creating reusable `useQuery` or `useMutation` hooks for API endpoints.

## Procedure
1. Create a new file in the `hooks/` or `lib/queries/` directory (e.g., `hooks/useUser.ts`).
2. Define the TypeScript interfaces for the API response and any required parameters.
3. Write an asynchronous fetcher function that calls the API route (e.g., using `fetch` or `axios`).
4. Export a custom hook that wraps `useQuery` or `useMutation` from `@tanstack/react-query`.
5. Set appropriate query keys and options (e.g., `staleTime`).

## Template
Use the [Query Hook Template](./assets/query-hook-template.ts) for boilerplate.