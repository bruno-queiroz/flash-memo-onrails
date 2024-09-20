type t = {
  onSearch: JsxEventU.Form.t => promise<unit>,
  deckSelectRef: ReactDOM.Ref.currentDomRef,
  decks: option<GetDecks.response>,
  searchInputRef: ReactDOM.Ref.currentDomRef,
  isPending: bool,
  isError: bool,
  error: ReactQuery.error,
  data: option<Types.response<SearchCards.t>>,
  reSearchCards: unit => unit,
}

let useSearchCards = () => {
  let deckSelectRef = React.useRef(Nullable.null)
  let searchInputRef = React.useRef(Nullable.null)

  let {data, isError, error, isPending, mutate} = ReactQuery.useMutation({
    mutationFn: data => SearchCards.get(data),
    mutationKey: Some(["searchCards"]),
    onSuccess: () => {Console.log("Search successful")},
  })

  let {data: decks} = ReactQuery.useQuery({
    queryFn: GetDecks.get,
    queryKey: ["decksData"],
  })

  let onSearch = async event => {
    let event = (Obj.magic(event): WebApi.event)
    event.preventDefault()

    let deckSelect = (Obj.magic(deckSelectRef.current): WebApi.document)
    let searchInput = (Obj.magic(searchInputRef.current): WebApi.document)

    let _ = mutate({
      deckId: deckSelect.value,
      query: searchInput.value,
    })
  }

  let reSearchCards = () => {
    let deckSelect = (Obj.magic(deckSelectRef.current): WebApi.document)
    let searchInput = (Obj.magic(searchInputRef.current): WebApi.document)

    let _ = mutate({
      deckId: deckSelect.value,
      query: searchInput.value,
    })
  }

  {
    onSearch,
    deckSelectRef,
    decks,
    searchInputRef,
    isPending,
    isError,
    error,
    data,
    reSearchCards,
  }
}
