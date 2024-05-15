import { PayloadAction, createSlice } from "@reduxjs/toolkit";

interface SelectedCard {
  cardId: string;
  front: string;
  back: string;
}

export const selectedCardSlice = createSlice({
  name: "selectedCard",
  initialState: {
    data: {
      cardId: "",
      front: "",
      back: "",
    },
  },
  reducers: {
    setSelectedCard: (state, action: PayloadAction<SelectedCard>) => {
      state.data = action.payload;
    },
  },
});

export const { setSelectedCard: setSelectedDeck } = selectedCardSlice.actions;

export default selectedCardSlice.reducer;
