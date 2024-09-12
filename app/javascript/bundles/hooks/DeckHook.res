type useDecks = {
  isPending: bool,
  isError: bool,
  decks: Fetch.defaultResponse<array<Types.deck>>,
  openCreateDeckModal: unit => unit,
}

let useDecks = () => {
  let {data: decks, isError, isPending} = ReactQuery.useQuery({
    queryKey: ["decksData"],
    queryFn: GetDecks.get,
  })

  let dispatch = ReduxHooks.useAppDispatch

  let openCreateDeckModal = () => {
    dispatch(DeckSlice.setIsCreateDeckModalOpen(true))
  }

  {
    isPending,
    isError,
    decks,
    openCreateDeckModal,
  }
}
