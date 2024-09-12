type store = {card: DeckSlice.initialState}

let store = Redux.configureStore({
  reducer: {
    card: DeckSlice.deckReducer,
  },
})
