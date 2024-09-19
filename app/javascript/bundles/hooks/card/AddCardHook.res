type t = {
  submitCard: JsxEventU.Form.t => promise<unit>,
  cardSelectRef: ReactDOM.Ref.currentDomRef,
  decks: option<GetDecks.response>,
  cardFrontInputRef: ReactDOM.Ref.currentDomRef,
  cardBackInputRef: ReactDOM.Ref.currentDomRef,
  isPending: bool,
}

let useAddCard = () => {
  let {data: decks} = ReactQuery.useQuery({
    queryKey: ["decksData"],
    queryFn: GetDecks.get,
  })

  let queryClient = ReactQuery.useQueryClient()

  let {mutateAsync: cardMutate, isPending} = ReactQuery.useMutation({
    mutationFn: newCard => CreateCard.post(newCard),
    onSuccess: () => queryClient.invalidateQueries({queryKey: ["decksData"]}),
  })

  let dispatch = Redux.useDispatch()

  let cardSelectRef = React.useRef(Nullable.null)
  let cardFrontInputRef = React.useRef(Nullable.null)
  let cardBackInputRef = React.useRef(Nullable.null)

  let submitCard = async (event: JsxEventU.Form.t) => {
    let event = (Obj.magic(event): WebApi.event)
    event.preventDefault()

    let cardSelect = (Obj.magic(cardSelectRef.current): WebApi.document)
    let cardFront = (Obj.magic(cardFrontInputRef.current): WebApi.document)
    let cardBack = (Obj.magic(cardBackInputRef.current): WebApi.document)

    let newCard: CreateCard.postCardParams = {
      card: {
        deck_id: cardSelect.value,
        front: cardFront.value,
        back: cardBack.value,
        ease_factor: 1.7,
        interval: 0,
        repetitions: 0,
        review_at: WebApi.date(1970),
      },
    }

    try {
      let _ = await cardMutate(newCard)
      let _ = dispatch(
        NotificationSlice.setNotification({
          isShowing: true,
          isOk: true,
          msg: "Card added successfully",
        }),
      )
      let cardFrontInput = (Obj.magic(cardFrontInputRef.current): WebApi.document)
      let cardBackInput = (Obj.magic(cardBackInputRef.current): WebApi.document)

      cardFrontInput.value = ""
      cardBackInput.value = ""
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

  {
    submitCard,
    cardSelectRef,
    decks,
    cardFrontInputRef,
    cardBackInputRef,
    isPending,
  }
}
