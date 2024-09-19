type t = {
  deck: DeckSlice.initialState,
  selectedDeck: SelectedDeckSlice.initialState,
  notification: NotificationSlice.initialState,
}

let store = Redux.configureStore({
  reducer: {
    deck: DeckSlice.deckReducer,
    selectedDeck: SelectedDeckSlice.selectedDeckReducer,
    notification: NotificationSlice.notificationReducer,
  },
})
