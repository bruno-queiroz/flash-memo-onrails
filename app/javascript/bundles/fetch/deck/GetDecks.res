let params = {
  "method": "GET",
  "headers": {
    "Content-Type": "application/json",
    "Accept": "application/json",
  },
}

let get = async () => {
  let response = await Fetch.fetch("/decks/data.json", params)
  let data: Fetch.defaultResponse<array<Types.deck>> = await Fetch.json(response)

  switch (data["isOk"]->Nullable.toOption, data["msg"]->Nullable.toOption) {
  | (Some(false), Some(errMsg)) => Exn.raiseError(errMsg)
  | (Some(true), _) => ()
  | _ => Exn.raiseError("something went wrong")
  }

  data
}
