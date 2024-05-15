import { configureStore } from "@reduxjs/toolkit";

import deckReducer from "./reducers/deckSlice";
import selectedDeckReducer from "./reducers/selectedDeckSlice";
import selectedCardReducer from "./reducers/selectedCardSlice";
import notificationReducer from "./reducers/notificationSlice";

export const store = configureStore({
  reducer: {
    deck: deckReducer,
    selectedDeck: selectedDeckReducer,
    selectedCard: selectedCardReducer,
    notification: notificationReducer,
  },
});

export type RootState = ReturnType<typeof store.getState>;
export type AppDispatch = typeof store.dispatch;
