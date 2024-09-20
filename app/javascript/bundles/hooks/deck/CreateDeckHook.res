type t = {
  isCreateDeckModalOpen: bool,
  setIsModalOpen: bool => unit,
  createDeck: JsxEventU.Form.t => promise<unit>,
  deckNameRef: ReactDOM.Ref.currentDomRef,
  isPending: bool,
}

let dialog_animation_time = 150

let useCreateDeckModal = () => {
  let deckNameRef = React.useRef(Nullable.null)
  let queryClient = ReactQuery.useQueryClient()

  let isCreateDeckModalOpen = Redux.useSelector((state: Store.t) =>
    state.deck.isCreateDeckModalOpen
  )
  let dispatch = Redux.useDispatch()

  let setIsModalOpen = (isOpen: bool) => {
    dispatch(DeckSlice.setIsCreateDeckModalOpen(isOpen))
  }

  let {mutateAsync: createDeckMutate, isPending} = ReactQuery.useMutation({
    mutationFn: newDeck => CreateDeck.create(newDeck),
    mutationKey: None,
    onSuccess: () => {
      queryClient.invalidateQueries({queryKey: ["decksData"]})
    },
  })

  let createDeck = async (event: JsxEventU.Form.t) => {
    let event = (Obj.magic(event): WebApi.event)
    event.preventDefault()

    let title = (Obj.magic(deckNameRef.current): WebApi.document)

    let newDeck: CreateDeck.postDeckParams = {
      deck: {
        title: title.value,
      },
    }

    try {
      let _ = await createDeckMutate(newDeck)
      let _ = dispatch(
        NotificationSlice.setNotification({
          isShowing: true,
          isOk: true,
          msg: "Deck created successfully",
        }),
      )
      dispatch(DeckSlice.setIsCreateDeckModalOpen(false))
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
    let inputRef = (Obj.magic(deckNameRef.current): WebApi.document)

    switch (isCreateDeckModalOpen, inputRef) {
    | (true, deckNameInput) =>
      let _ = setTimeout(() => {
        deckNameInput.focus()
      }, dialog_animation_time)
    | _ => ()
    }

    None
  }, [isCreateDeckModalOpen])

  {
    isCreateDeckModalOpen,
    setIsModalOpen,
    createDeck,
    deckNameRef,
    isPending,
  }
}
