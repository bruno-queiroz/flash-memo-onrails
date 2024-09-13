type t = {deck: DeckSlice.initialState, selectedDeck: SelectedDeckSlice.initialState}

let store = Redux.configureStore({
  reducer: {
    deck: DeckSlice.deckReducer,
    selectedDeck: SelectedDeckSlice.selectedDeckReducer,
  },
})
