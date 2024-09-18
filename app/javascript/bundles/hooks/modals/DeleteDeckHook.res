type t = {
  isDeleteDeckModalOpen: bool,
  setIsModalOpen: bool => unit,
  selectedDeckTitle: string,
  closeModal: unit => unit,
  deleteSelectedDeck: unit => promise<unit>,
  isPending: bool,
}

let useDeckDeleteModal = () => {
  let isDeleteDeckModalOpen = Redux.useSelector((state: Store.t) =>
    state.deck.isDeleteDeckModalOpen
  )
  let selectedDeckId = Redux.useSelector((state: Store.t) => state.selectedDeck.data.deckId)
  let selectedDeckTitle = Redux.useSelector((state: Store.t) => state.selectedDeck.data.deckTitle)

  let dispatch = Redux.useDispatch()
  let setIsModalOpen = (isOpen: bool) => {
    dispatch(DeckSlice.setIsDeleteDeckModalOpen(isOpen))
  }

  let queryClient = ReactQuery.useQueryClient()

  let {mutateAsync: deleteDeckMutate, isPending} = ReactQuery.useMutation({
    mutationFn: (deckId: string) => DeleteDeck.delete(deckId),
    onSuccess: () => queryClient.invalidateQueries({queryKey: ["decksData"]}),
  })

  let deleteSelectedDeck = async () => {
    try {
      let _ = await deleteDeckMutate(selectedDeckId)
      let _ = dispatch(
        NotificationSlice.setNotification({
          isShowing: true,
          isOk: true,
          msg: "Deck deleted successfully",
        }),
      )

      dispatch(DeckSlice.setIsDeleteDeckModalOpen(false))
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

  let closeModal = () => {
    dispatch(DeckSlice.setIsDeleteDeckModalOpen(false))
  }

  {
    isDeleteDeckModalOpen,
    setIsModalOpen,
    selectedDeckTitle,
    closeModal,
    deleteSelectedDeck,
    isPending,
  }
}
