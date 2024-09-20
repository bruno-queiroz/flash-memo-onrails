type t = {
  frontTextFormatted: array<option<Js.String.t>>,
  backTextFormatted: array<option<Js.String.t>>,
  openEditModal: unit => unit,
  deleteSelectedCard: unit => promise<unit>,
  isPending: bool,
}

let useSearchCardItem = (front, back, id, reSearchCards) => {
  let queryClient = ReactQuery.useQueryClient()
  let {mutateAsync: deleteCardMutate, isPending} = ReactQuery.useMutation({
    mutationFn: (cardId: string) => DeleteCard.delete(cardId),
    mutationKey: None,
    onSuccess: () => {
      queryClient.invalidateQueries({queryKey: ["searchCards"]})
      reSearchCards()
    },
  })

  let dispatch = Redux.useDispatch()

  let openEditModal = () => {
    let _ = dispatch(SelectedCardSlice.setSelectedCard({front, back, cardId: id}))
    dispatch(CardSlice.setIsEditCardModalOpen(true))
  }

  let deleteSelectedCard = async () => {
    let response = await deleteCardMutate(id)

    dispatch(
      NotificationSlice.setNotification({
        isShowing: true,
        isOk: response.isOk,
        msg: response.msg,
      }),
    )
  }

  let frontTextFormatted = FormatText.format(front)
  let backTextFormatted = FormatText.format(back)

  {
    frontTextFormatted,
    backTextFormatted,
    openEditModal,
    deleteSelectedCard,
    isPending,
  }
}
