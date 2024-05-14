import { PayloadAction, createSlice } from "@reduxjs/toolkit";

interface Notification {
  isShowing: boolean;
  isOk: boolean;
  msg: string;
}

export const notificationSlice = createSlice({
  name: "notification",
  initialState: {
    content: {
      isShowing: false,
      isOk: false,
      msg: "",
    },
  },
  reducers: {
    setNotification: (state, action: PayloadAction<Notification>) => {
      state.content = action.payload;
    },
  },
});

export const { setNotification } = notificationSlice.actions;

export default notificationSlice.reducer;
