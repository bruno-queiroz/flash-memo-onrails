import { createSlice } from "@reduxjs/toolkit";

export const cardSlice = createSlice({
  name: "card",
  initialState: {
    isEditCardModalOpen: false,
  },
  reducers: {
    setIsEditCardModalOpen: (state, action) => {
      state.isEditCardModalOpen = action.payload;
    },
  },
});

export const { setIsEditCardModalOpen } = cardSlice.actions;

export default cardSlice.reducer;
