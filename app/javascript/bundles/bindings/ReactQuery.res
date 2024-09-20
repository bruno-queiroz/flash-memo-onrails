type useQueryParams<'a> = {
  queryKey: array<string>,
  queryFn: unit => promise<'a>,
}

type useQueryReturnValues<'a> = {
  data: option<'a>,
  isError: bool,
  isPending: bool,
}

type queries = {refetchOnWindowFocus: bool}

type defaultOptions = {queries: queries}

type queryClientConfig = {defaultOptions: defaultOptions}

type invalidateQueriesFilter = {queryKey: array<string>}

type queryClient = {invalidateQueries: invalidateQueriesFilter => unit}

type error = {message: string}

type useMutationResult<'a, 'b> = {
  data: option<'b>,
  mutateAsync: 'a,
  mutate: 'a,
  isPending: bool,
  isError: bool,
  error: error,
}

type useMutationParams<'a> = {
  mutationFn: 'a,
  mutationKey: option<array<string>>,
  onSuccess: unit => unit,
}

@module("@tanstack/react-query")
external useQuery: useQueryParams<'a> => useQueryReturnValues<'a> = "useQuery"

@new @module("@tanstack/react-query")
external queryClient: queryClientConfig => queryClientConfig = "QueryClient"

module QueryClientProvider = {
  @react.component @module("@tanstack/react-query")
  external make: (~client: queryClientConfig, ~children: React.element) => React.element =
    "QueryClientProvider"
}

@module("@tanstack/react-query")
external useQueryClient: unit => queryClient = "useQueryClient"
@send external invalidateQueries: invalidateQueriesFilter => unit = "invalidateQueries"

@module("@tanstack/react-query")
external useMutation: useMutationParams<'a> => useMutationResult<'a, 'b> = "useMutation"
