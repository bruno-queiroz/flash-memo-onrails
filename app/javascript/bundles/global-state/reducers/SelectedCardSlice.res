type data = {
  cardId: string,
  front: string,
  back: string,
}

type initialState = {mutable data: data}

type reducers = {setSelectedCard: (initialState, Redux.action<data>) => unit}

type selectedCardActions = {setSelectedCard: data => unit}

let selectedCardSlice = Redux.createSlice(
  (
    {
      name: "selectedDeck",
      initialState: {
        data: {
          cardId: "",
          front: "",
          back: "",
        },
      },
      reducers: {
        setSelectedCard: (state, action) => {
          state.data = action.payload
        },
      },
    }: Redux.createSlice<initialState, reducers>
  ),
)

let setSelectedCard = selectedCardSlice.actions.setSelectedCard

let selectedCardReducer = selectedCardSlice.reducer
