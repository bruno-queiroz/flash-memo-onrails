type useQueryParams<'a> = {
  queryKey: array<string>,
  queryFn: unit => promise<'a>,
}

type useQueryReturnValues<'a> = {
  data: 'a,
  isError: bool,
  isPending: bool,
}

type queries = {refetchOnWindowFocus: bool}

type defaultOptions = {queries: queries}

type queryClient = {defaultOptions: defaultOptions}

@module("@tanstack/react-query")
external useQuery: useQueryParams<'a> => useQueryReturnValues<'a> = "useQuery"

@new @module("@tanstack/react-query")
external queryClient: queryClient => queryClient = "QueryClient"

module QueryClientProvider = {
  @react.component @module("@tanstack/react-query")
  external make: (~client: queryClient, ~children: React.element) => React.element =
    "QueryClientProvider"
}
