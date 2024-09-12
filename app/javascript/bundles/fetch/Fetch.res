type t<'data>

type defaultResponse<'payload> = {
  "msg": Nullable.t<string>,
  "isOk": Nullable.t<bool>,
  "data": Nullable.t<'payload>,
}

@val @scope("globalThis")
external fetch: (string, 'params) => promise<t<defaultResponse<'payload>>> = "fetch"

@send external json: t<'data> => promise<'data> = "json"
