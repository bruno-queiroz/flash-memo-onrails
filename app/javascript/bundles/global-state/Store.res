type t = {
  deck: DeckSlice.initialState,
  card: CardSlice.initialState,
  selectedDeck: SelectedDeckSlice.initialState,
  selectedCard: SelectedCardSlice.initialState,
  notification: NotificationSlice.initialState,
}

let store = Redux.configureStore({
  reducer: {
    deck: DeckSlice.deckReducer,
    card: CardSlice.cardReducer,
    selectedDeck: SelectedDeckSlice.selectedDeckReducer,
    selectedCard: SelectedCardSlice.selectedCardReducer,
    notification: NotificationSlice.notificationReducer,
  },
})
