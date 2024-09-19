type useDeckStatus = {
  isOptionsActive: bool,
  openDeckOptions: unit => unit,
  openDeleteDeckModal: unit => unit,
  openEditNameDeckModal: unit => unit,
}

let useDeckStatus = (title: string, id: string) => {
  let (isOptionsActive, setIsOptionsActive) = React.useState(() => false)

  let dispatch = Redux.useDispatch()
  let deckId = Redux.useSelector((state: Store.t) => state.selectedDeck.data.deckId)

  let openDeckOptions = () => {
    setIsOptionsActive(isOptionsActive => !isOptionsActive)
    dispatch(SelectedDeckSlice.setSelectedDeck({deckId: id, deckTitle: title}))
  }

  let openDeleteDeckModal = () => {
    dispatch(DeckSlice.setIsDeleteDeckModalOpen(true))
  }

  let openEditNameDeckModal = () => {
    dispatch(DeckSlice.setIsEditDeckNameModalOpen(true))
  }

  React.useEffect(() => {
    let body = WebApi.document.querySelector("body")

    let listener = (event: WebApi.mouseEvent) => {
      let target = event.target
      let isTheOptionClicked = id === deckId && target.id === "deck-option"

      if !isTheOptionClicked {
        setIsOptionsActive(_ => false)
      }
    }

    switch body {
    | Some(body) => body.addEventListener("click", listener)
    | None => ()
    }

    let cleanUp = () => {
      switch body {
      | Some(body) => body.removeEventListener("click", listener)
      | None => ()
      }
    }

    Some(cleanUp)
  }, [deckId])

  {
    openDeckOptions,
    isOptionsActive,
    openDeleteDeckModal,
    openEditNameDeckModal,
  }
}
