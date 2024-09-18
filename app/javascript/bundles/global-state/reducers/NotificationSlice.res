type data = {
  isShowing: bool,
  isOk: bool,
  msg: string,
}

type initialState = {mutable content: data}

type reducers = {setNotification: (initialState, Redux.action<data>) => unit}

type notificationActions = {setNotification: data => unit}

let notificationSlice = Redux.createSlice(
  (
    {
      name: "notification",
      initialState: {
        content: {
          isShowing: false,
          isOk: false,
          msg: "",
        },
      },
      reducers: {
        setNotification: (state, action) => {
          state.content = action.payload
        },
      },
    }: Redux.createSlice<initialState, reducers>
  ),
)

let setNotification = notificationSlice.actions.setNotification

let notificationReducer = notificationSlice.reducer
