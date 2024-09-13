type data = {
  deckId: string,
  deckTitle: string,
}

type initialState = {mutable data: data}

type reducers = {setSelectedDeck: (initialState, Redux.action<data>) => unit}

type selectedDeckActions = {setSelectedDeck: data => unit}

let selectedDeckSlice = Redux.createSlice(
  (
    {
      name: "selectedDeck",
      initialState: {
        data: {
          deckId: "",
          deckTitle: "",
        },
      },
      reducers: {
        setSelectedDeck: (state, action) => {
          state.data = action.payload
        },
      },
    }: Redux.createSlice<initialState, reducers>
  ),
)

let setSelectedDeck = selectedDeckSlice.actions.setSelectedDeck

let selectedDeckReducer = selectedDeckSlice.reducer
