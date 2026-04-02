---
name: create-next-component
description: 'Create a new React component for a Next.js application with TypeScript. Use for creating UI elements, Server Components, or Client Components.'
---

# Create Next.js Component

## When to Use
- Building reusable UI components
- Extracting logic into smaller, maintainable pieces
- Creating Client Components that require interactivity (`"use client"`)

## Procedure
1. Determine if the component should be a Server Component (default) or a Client Component (needs `"use client"` directive).
2. Create a `.tsx` file in the `components/` directory (e.g., `components/ui/Button.tsx`).
3. Define strict TypeScript interfaces for the component's `props`.
4. Export the component as the default export (or named export if preferred by the project conventions).
5. Use conditional class merging (e.g., `tailwind-merge` + `clsx`) if using Tailwind CSS.
6. Use Next.js optimized components like `next/image` and `next/link` where appropriate.

## Template
Use the [Component Template](./assets/component-template.tsx) for boilerplate.