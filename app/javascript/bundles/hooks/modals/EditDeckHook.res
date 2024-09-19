type t = {
  isEditDeckNameModalOpen: bool,
  setIsModalOpen: bool => unit,
  onEditDeckName: JsxEventU.Form.t => promise<unit>,
  deckNameInputRef: ReactDOM.Ref.currentDomRef,
}

let useEditDeckNameModal = () => {
  let deckNameInputRef = React.useRef(Nullable.null)

  let dispatch = Redux.useDispatch()

  let isEditDeckNameModalOpen = Redux.useSelector((state: Store.t) =>
    state.deck.isEditDeckNameModalOpen
  )
  let selectedDeckId = Redux.useSelector((state: Store.t) => state.selectedDeck.data.deckId)
  let selectedDeckTitle = Redux.useSelector((state: Store.t) => state.selectedDeck.data.deckTitle)

  let queryClient = ReactQuery.useQueryClient()
  let {mutateAsync: renameDeckMutate} = ReactQuery.useMutation({
    mutationFn: data => RenameDeck.patch(data),
    onSuccess: () => queryClient.invalidateQueries({queryKey: ["decksData"]}),
  })

  let setIsModalOpen = (isOpen: bool) => {
    dispatch(DeckSlice.setIsEditDeckNameModalOpen(isOpen))
  }

  let onEditDeckName = async (event: JsxEventU.Form.t) => {
    let event = (Obj.magic(event): WebApi.event)
    event.preventDefault()

    let deckName = (Obj.magic(deckNameInputRef.current): WebApi.document)
    try {
      let _ = await renameDeckMutate({
        deckId: selectedDeckId,
        deckTitle: deckName.value,
      })
      let _ = dispatch(
        NotificationSlice.setNotification({
          isShowing: true,
          isOk: true,
          msg: "Deck name updated successfully",
        }),
      )
      dispatch(DeckSlice.setIsEditDeckNameModalOpen(false))
    } catch {
    | Exn.Error(obj) =>
      switch Exn.message(obj) {
      | Some(msg) =>
        dispatch(
          NotificationSlice.setNotification({
            isShowing: true,
            isOk: false,
            msg,
          }),
        )
      | _ =>
        dispatch(
          NotificationSlice.setNotification({
            isShowing: true,
            isOk: false,
            msg: "Something went wrong",
          }),
        )
      }
    }
  }

  React.useEffect(() => {
    let deckName = (Obj.magic(deckNameInputRef.current): WebApi.document)
    if selectedDeckTitle {
      deckName.value = selectedDeckTitle
    }

    None
  }, [isEditDeckNameModalOpen])

  {
    isEditDeckNameModalOpen,
    setIsModalOpen,
    onEditDeckName,
    deckNameInputRef,
  }
}
