type initialState = {
  mutable isCreateDeckModalOpen: bool,
  mutable isEditModalOpen: bool,
  mutable isDeleteDeckModalOpen: bool,
  mutable isEditDeckNameModalOpen: bool,
}

type deckSliceActions = {
  setIsCreateDeckModalOpen: bool => unit,
  setIsEditDeckModalOpen: bool => unit,
  setIsDeleteDeckModalOpen: bool => unit,
  setIsEditDeckNameModalOpen: bool => unit,
}

type reducers = {
  setIsCreateDeckModalOpen: (initialState, Redux.action<bool>) => unit,
  setIsEditDeckModalOpen: (initialState, Redux.action<bool>) => unit,
  setIsDeleteDeckModalOpen: (initialState, Redux.action<bool>) => unit,
  setIsEditDeckNameModalOpen: (initialState, Redux.action<bool>) => unit,
}

let deckSlice: Redux.slice<initialState, deckSliceActions> = Redux.createSlice(
  (
    {
      name: "deck",
      initialState: {
        isCreateDeckModalOpen: false,
        isEditModalOpen: false,
        isDeleteDeckModalOpen: false,
        isEditDeckNameModalOpen: false,
      },
      reducers: {
        setIsCreateDeckModalOpen: (state, action) => {
          state.isCreateDeckModalOpen = action.payload
        },
        setIsEditDeckModalOpen: (state, action) => {
          state.isEditModalOpen = action.payload
        },
        setIsDeleteDeckModalOpen: (state, action) => {
          state.isDeleteDeckModalOpen = action.payload
        },
        setIsEditDeckNameModalOpen: (state, action) => {
          state.isEditDeckNameModalOpen = action.payload
        },
      },
    }: Redux.createSlice<initialState, reducers>
  ),
)

let setIsCreateDeckModalOpen = deckSlice.actions.setIsCreateDeckModalOpen
let setIsEditDeckModalOpen = deckSlice.actions.setIsEditDeckModalOpen
let setIsDeleteDeckModalOpen = deckSlice.actions.setIsDeleteDeckModalOpen
let setIsEditDeckNameModalOpen = deckSlice.actions.setIsEditDeckNameModalOpen

let deckReducer = deckSlice.reducer
