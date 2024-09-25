type t = {
  isStudyDeckLoading: bool,
  isMutateCardLoading: bool,
  cardsCounter: Count.t,
  onReset: unit => promise<unit>,
  onReturnCard: unit => unit,
  currentCard: Types.card,
  isShowingAnswer: bool,
  reviewCard: (~quality: int) => promise<unit>,
  setIsShowingAnswer: (bool => bool) => unit,
  openEditCardModal: unit => unit,
}

type urlParams = {deckTitle: string}

let cards: ref<array<Types.card>> = ref([])
let reviewedCards: array<Types.card> = []

let useStudy = () => {
  let (isStudyDeckLoading, setIsStudyDeckLoading) = React.useState(() => false)

  let {deckTitle}: urlParams = ReactRouter.useParams()
  let navigate = ReactRouter.useNavigate()

  let {mutateAsync: cardMutate, isPending: isMutateCardLoading} = ReactQuery.useMutation({
    mutationFn: data => EditCardInterval.patch(data),
    mutationKey: None,
    onSuccess: () => Console.log("card interval updated"),
  })

  let dispatch = Redux.useDispatch()

  let (cardsCounter, setCardsCounter) = React.useState((): Count.t => {
    newCards: 0,
    resetCards: 0,
    reviewCards: 0,
  })

  let (isShowingAnswer, setIsShowingAnswer) = React.useState(() => false)
  let (currentCard, setCurrentCard) = React.useState((): Types.card => {
    front: "",
    back: "",
    ease_factor: 0.0,
    id: "",
    interval: 0,
    is_reset: false,
    repetitions: 0,
    review_at: 0,
  })

  React.useEffect(_ => {
    let getData = async () => {
      try {
        let response = await StudyDeck.get(deckTitle)

        switch response.data->Array.length {
        | 0 =>
          navigate("/decks")
          dispatch(
            NotificationSlice.setNotification({
              isShowing: true,
              isOk: false,
              msg: "No cards to study",
            }),
          )
        | _ =>
          cards := response.data

          setCardsCounter(_ => Count.cards(~cards=cards.contents))

          let lastCard = cards.contents[cards.contents->Array.length - 1]
          switch lastCard {
          | Some(lastCard) => setCurrentCard(_ => lastCard)
          | None => ()
          }
        }
      } catch {
      | _ =>
        setIsStudyDeckLoading(_ => false)
        // navigate("/decks")
        dispatch(
          NotificationSlice.setNotification({
            isShowing: true,
            isOk: false,
            msg: "Failed to get deck",
          }),
        )
      }
    }
    let _ = getData()
    None
  }, [])

  let reviewCard = async (~quality: int) => {
    let optionCard = cards.contents->Array.pop

    switch optionCard {
    | Some(card) =>
      card.is_reset = false
      reviewedCards->Array.push(card)

      let reviewedCard = Evaluate.card(~card, ~quality)
      try {
        let _ = await cardMutate(reviewedCard)

        switch cards.contents->Array.length {
        | 0 =>
          navigate("/decks")
          dispatch(
            NotificationSlice.setNotification({
              isShowing: true,
              isOk: true,
              msg: "Deck reviewed successfully",
            }),
          )

        | _ =>
          setCardsCounter(_ => Count.cards(~cards=cards.contents))

          let lastCard = cards.contents[cards.contents->Array.length - 1]
          switch lastCard {
          | Some(lastCard) => setCurrentCard(_ => lastCard)
          | None => ()
          }

          setIsShowingAnswer(_ => false)
        }
      } catch {
      | _ =>
        cards.contents->Array.push(card)
        let _ = reviewedCards->Array.pop

        dispatch(
          NotificationSlice.setNotification({
            isShowing: true,
            isOk: false,
            msg: "Failed to review card",
          }),
        )
      }

    | None => ()
    }
  }

  let onReset = async () => {
    let card = cards.contents->Array.pop
    switch card {
    | Some(card) => {
        card.is_reset = true
        cards.contents->Array.unshift(card)
        reviewedCards->Array.push(card)

        let reviewedCard = Evaluate.card(~card, ~quality=Constants.reset_quality_value)
        try {
          let _ = await cardMutate(reviewedCard)

          setCardsCounter(_ => Count.cards(~cards=cards.contents))

          let lastCard = cards.contents[cards.contents->Array.length - 1]
          switch lastCard {
          | Some(lastCard) => setCurrentCard(_ => lastCard)
          | None => ()
          }

          setIsShowingAnswer(_ => false)
        } catch {
        | _ =>
          card.is_reset = false
          cards.contents->Array.push(card)
          let _ = cards.contents->Array.shift

          dispatch(
            NotificationSlice.setNotification({
              isShowing: true,
              isOk: false,
              msg: "Failed to reset card",
            }),
          )
        }
      }
    | None => ()
    }
  }

  let onReturnCard = () => {
    let reviewedCard = reviewedCards->Array.pop
    let card = cards.contents->Array.shift

    switch [reviewedCard, card] {
    | [Some(reviewedCard), Some(card)] =>
      if reviewedCard.is_reset {
        card.is_reset = false
        cards.contents->Array.push(card)
      } else {
        cards.contents->Array.push(reviewedCard)
      }
    | _ => ()
    }

    setCardsCounter(_ => Count.cards(~cards=cards.contents))

    let lastCard = cards.contents[cards.contents->Array.length - 1]
    switch lastCard {
    | Some(lastCard) => setCurrentCard(_ => lastCard)
    | None => ()
    }

    setIsShowingAnswer(_ => false)
  }

  let openEditCardModal = () => {
    let _ = dispatch(
      SelectedCardSlice.setSelectedCard({
        front: currentCard.front,
        back: currentCard.back,
        cardId: currentCard.id,
      }),
    )
    dispatch(CardSlice.setIsEditCardModalOpen(true))
  }

  {
    isStudyDeckLoading,
    isMutateCardLoading,
    cardsCounter,
    onReset,
    onReturnCard,
    currentCard,
    isShowingAnswer,
    setIsShowingAnswer,
    reviewCard,
    openEditCardModal,
  }
}
