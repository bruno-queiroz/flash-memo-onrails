import { PayloadAction, createSlice } from "@reduxjs/toolkit";

interface SelectedDeck {
  deckId: string;
  deckTitle: string;
}

export const selectedDeckSlice = createSlice({
  name: "selectedDeck",
  initialState: {
    data: {
      deckId: "",
      deckTitle: "",
    },
  },
  reducers: {
    setSelectedDeck: (state, action: PayloadAction<SelectedDeck>) => {
      state.data = action.payload;
    },
  },
});

export const { setSelectedDeck } = selectedDeckSlice.actions;

export default selectedDeckSlice.reducer;
