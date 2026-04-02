import { Metadata } from 'next';

export const metadata: Metadata = {
  title: 'Page Title',
  description: 'Page Description',
};

interface PageProps {
  params: { slug: string };
  searchParams: { [key: string]: string | string[] | undefined };
}

export default async function Page({ params, searchParams }: PageProps) {
  return (
    <main className="flex min-h-screen flex-col items-center justify-between p-24">
      <h1 className="text-4xl font-bold">New Page</h1>
      {/* Add your content here */}
    </main>
  );
}
