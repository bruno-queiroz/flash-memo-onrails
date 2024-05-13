import { createSlice } from "@reduxjs/toolkit";

export const deckSlice = createSlice({
  name: "deck",
  initialState: {
    isCreateDeckModalOpen: false,
    isEditModalOpen: false,
    isDeleteDeckModalOpen: false,
    isEditDeckNameModalOpen: false,
  },
  reducers: {
    setIsCreateDeckModalOpen: (state, action) => {
      state.isCreateDeckModalOpen = action.payload;
    },
    setIsEditDeckModalOpen: (state, action) => {
      state.isEditModalOpen = action.payload;
    },
    setIsDeleteDeckModalOpen: (state, action) => {
      state.isDeleteDeckModalOpen = action.payload;
    },
    setIsEditDeckNameModalOpen: (state, action) => {
      state.isEditDeckNameModalOpen = action.payload;
    },
  },
});

export const {
  setIsCreateDeckModalOpen,
  setIsDeleteDeckModalOpen,
  setIsEditDeckModalOpen,
  setIsEditDeckNameModalOpen,
} = deckSlice.actions;

export default deckSlice.reducer;
