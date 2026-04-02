import * as React from 'react';

export interface MyComponentProps extends React.HTMLAttributes<HTMLDivElement> {
  title: string;
  description?: string;
}

export default function MyComponent({
  title,
  description,
  className = '',
  ...props
}: MyComponentProps) {
  return (
    <div className={`p-4 border rounded-lg shadow-sm ${className}`} {...props}>
      <h3 className="text-lg font-medium text-gray-900">{title}</h3>
      {description && (
        <p className="mt-1 text-sm text-gray-500">{description}</p>
      )}
    </div>
  );
}
