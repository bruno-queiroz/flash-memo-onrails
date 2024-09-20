type initialState = {mutable isEditCardModalOpen: bool}

type cardSliceActions = {setIsEditCardModalOpen: bool => unit}

type reducers = {setIsEditCardModalOpen: (initialState, Redux.action<bool>) => unit}

let cardSlice: Redux.slice<initialState, cardSliceActions> = Redux.createSlice(
  (
    {
      name: "deck",
      initialState: {
        isEditCardModalOpen: false,
      },
      reducers: {
        setIsEditCardModalOpen: (state, action) => {
          state.isEditCardModalOpen = action.payload
        },
      },
    }: Redux.createSlice<initialState, reducers>
  ),
)

let setIsEditCardModalOpen = cardSlice.actions.setIsEditCardModalOpen
let cardReducer = cardSlice.reducer
