---
name: create-next-page
description: 'Create a new Next.js App Router page with TypeScript. Use for adding new routes, pages, layouts, loading states, and error boundaries.'
---

# Create Next.js Page

## When to Use
- Adding a new route to the application
- Creating a `page.tsx` file for the App Router
- Setting up a layout, loading, or error file for a specific segment

## Procedure
1. Determine the correct path under the `app/` directory (e.g., `app/(dashboard)/users/`).
2. Create a `page.tsx` file exporting a default React component.
3. Use Next.js App Router best practices (e.g., Server Components by default).
4. Define TypeScript interfaces for `params` and `searchParams` if it's a dynamic route.
5. If necessary, create accompanying `layout.tsx`, `loading.tsx`, or `error.tsx` files.
6. Use Tailwind CSS for styling and `next/link` for navigation.

## Template
Use the [Page Template](./assets/page-template.tsx) for boilerplate.