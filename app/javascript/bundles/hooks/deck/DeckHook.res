type useDecks = {
  isPending: bool,
  isError: bool,
  decks: option<GetDecks.response>,
  openCreateDeckModal: unit => unit,
}

let useDecks = () => {
  let {data: decks, isError, isPending} = ReactQuery.useQuery({
    queryKey: ["decksData"],
    queryFn: GetDecks.get,
  })

  let dispatch = Redux.useDispatch()

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
