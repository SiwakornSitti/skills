import { useQuery, useMutation, useQueryClient } from '@tanstack/react-query';

// Types
export interface DataResponse {
  id: string;
  name: string;
}

export interface FetchError {
  message: string;
}

// Fetcher Function
const fetchData = async (id: string): Promise<DataResponse> => {
  const response = await fetch(`/api/data/${id}`);
  
  if (!response.ok) {
    throw new Error('Failed to fetch data');
  }
  
  return response.json();
};

// Query Hook
export function useDataQuery(id: string) {
  return useQuery<DataResponse, FetchError>({
    queryKey: ['data', id],
    queryFn: () => fetchData(id),
    staleTime: 1000 * 60 * 5, // 5 minutes
  });
}

// Mutation Hook
const updateData = async (newData: Partial<DataResponse>): Promise<DataResponse> => {
  const response = await fetch('/api/data', {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify(newData),
  });
  
  if (!response.ok) {
    throw new Error('Failed to update data');
  }
  
  return response.json();
};

export function useUpdateDataMutation() {
  const queryClient = useQueryClient();

  return useMutation<DataResponse, FetchError, Partial<DataResponse>>({
    mutationFn: updateData,
    onSuccess: (data) => {
      // Invalidate and refetch queries after successful mutation
      queryClient.invalidateQueries({ queryKey: ['data'] });
      // You can also optimistically update the cache here using queryClient.setQueryData
    },
  });
}
