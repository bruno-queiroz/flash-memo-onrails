import { configureStore } from "@reduxjs/toolkit";

import deckReducer from "./reducers/deckSlice";
import selectedDeckReducer from "./reducers/selectedDeckSlice";
import notificationReducer from "./reducers/notificationSlice";

export const store = configureStore({
  reducer: {
    deck: deckReducer,
    selectedDeck: selectedDeckReducer,
    notification: notificationReducer,
  },
});

export type RootState = ReturnType<typeof store.getState>;
export type AppDispatch = typeof store.dispatch;
