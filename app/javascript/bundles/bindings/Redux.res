type createSlice<'initialState, 'reducers> = {
  name: string,
  initialState: 'initialState,
  reducers: 'reducers,
}

type slice<'initialState, 'actions> = {
  actions: 'actions,
  reducer: 'initialState,
}

type configureStore<'reducers> = {reducer: 'reducers}

type useDispatch = {withTypes: unit => unit}

type useSelector = {withTypes: unit => unit}

type action<'payload> = {type_: string, payload: 'payload}

@module("@reduxjs/toolkit")
external createSlice: createSlice<'initialState, 'reducers> => slice<'initialState, 'actions> =
  "createSlice"
@send external reducer: slice<'initialState, 'actions> => 'initialState = "reducer"

@module("@reduxjs/toolkit")
external configureStore: configureStore<'reducers> => 'reducers = "configureStore"

@module("react-redux")
external useDispatch: useDispatch = "useDispatch"

@module("react-redux")
external useSelector: useSelector = "useSelector"

@send external withTypes: 'a => 'b = "withTypes"
