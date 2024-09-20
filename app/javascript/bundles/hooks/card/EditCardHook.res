type t = {
  isEditCardModalOpen: bool,
  setIsModalOpen: bool => unit,
  editCard: JsxEventU.Form.t => promise<unit>,
  cardFrontInputRef: ReactDOM.Ref.currentDomRef,
  cardBackInputRef: ReactDOM.Ref.currentDomRef,
  isEditCardLoading: bool,
}

let useEditCardModal = (reSearchCards: unit => unit) => {
  let queryClient = ReactQuery.useQueryClient()

  let {isPending: isEditCardLoading, mutateAsync: editCardMutate} = ReactQuery.useMutation({
    mutationFn: card => EditCardContent.patch(card),
    mutationKey: None,
    onSuccess: () => {
      reSearchCards()
      queryClient.invalidateQueries({queryKey: ["studyDeck"]})
    },
  })

  let front = Redux.useSelector((state: Store.t) => state.selectedCard.data.front)
  let back = Redux.useSelector((state: Store.t) => state.selectedCard.data.back)
  let cardId = Redux.useSelector((state: Store.t) => state.selectedCard.data.cardId)

  let isEditCardModalOpen = Redux.useSelector((state: Store.t) => state.card.isEditCardModalOpen)

  let dispatch = Redux.useDispatch()

  let cardFrontInputRef = React.useRef(Nullable.null)
  let cardBackInputRef = React.useRef(Nullable.null)

  let editCard = async event => {
    let event = (Obj.magic(event): WebApi.event)
    event.preventDefault()

    let cardFrontInput = (Obj.magic(cardFrontInputRef.current): WebApi.document)
    let cardBackInput = (Obj.magic(cardBackInputRef.current): WebApi.document)

    let card: EditCardContent.card = {
      front: cardFrontInput.value,
      back: cardBackInput.value,
    }

    switch (card.front === front, card.back === back) {
    | (true, true) =>
      let _ = dispatch(
        NotificationSlice.setNotification({
          isShowing: true,
          isOk: true,
          msg: "No changes",
        }),
      )

      let _ = dispatch(CardSlice.setIsEditCardModalOpen(false))
    | _ =>
      let response = await editCardMutate({cardId, card})

      let _ = dispatch(
        NotificationSlice.setNotification({
          isShowing: true,
          isOk: response.isOk,
          msg: response.msg,
        }),
      )

      dispatch(CardSlice.setIsEditCardModalOpen(false))
    }
  }

  let setIsModalOpen = (isOpen: bool) => {
    dispatch(CardSlice.setIsEditCardModalOpen(isOpen))
  }

  React.useEffect(() => {
    let cardFrontInput = (Obj.magic(cardFrontInputRef.current): WebApi.document)
    let cardBackInput = (Obj.magic(cardBackInputRef.current): WebApi.document)

    cardFrontInput.value = front
    cardBackInput.value = back

    None
  }, [isEditCardModalOpen])

  {
    isEditCardModalOpen,
    setIsModalOpen,
    editCard,
    cardFrontInputRef,
    cardBackInputRef,
    isEditCardLoading,
  }
}
