import { createSlice } from "@reduxjs/toolkit";

export const createDeckSlice = createSlice({
  name: "createDeck",
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
} = createDeckSlice.actions;

export default createDeckSlice.reducer;
