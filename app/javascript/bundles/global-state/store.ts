import { configureStore } from "@reduxjs/toolkit";

import deckReducer from "./reducers/deckSlice";
import selectedDeckReducer from "./reducers/selectedDeckSlice";

export const store = configureStore({
  reducer: {
    deck: deckReducer,
    selectedDeck: selectedDeckReducer,
  },
});

export type RootState = ReturnType<typeof store.getState>;
export type AppDispatch = typeof store.dispatch;
