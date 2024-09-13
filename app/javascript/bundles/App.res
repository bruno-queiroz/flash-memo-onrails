let queryClient = ReactQuery.queryClient({
  defaultOptions: {
    queries: {
      refetchOnWindowFocus: false,
    },
  },
})

@react.component
let make = () => {
  <ReactQuery.QueryClientProvider client=queryClient>
    <Redux.Provider store=Store.store>
      <ReactRouter.BrowserRouter>
        <Routes />
      </ReactRouter.BrowserRouter>
    </Redux.Provider>
  </ReactQuery.QueryClientProvider>
}
