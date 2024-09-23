let params = {
  "method": "GET",
  "headers": {
    "Content-Type": "application/json",
    "Accept": "application/json",
  },
}

type response = {
  isOk: bool,
  msg: string,
  data: array<Types.card>,
}

let get = async (deckTitle: string) => {
  let response = await Fetch.fetch(`decks/${deckTitle}`, params)
  let data: Fetch.defaultResponse<array<Types.card>> = await Fetch.json(response)

  switch (data["isOk"]->Nullable.toOption, data["msg"]->Nullable.toOption) {
  | (Some(false), Some(errMsg)) => Exn.raiseError(errMsg)
  | (Some(true), _) => ()
  | _ => Exn.raiseError("something went wrong")
  }

  let data = (Obj.magic(data): response)
  data
}
