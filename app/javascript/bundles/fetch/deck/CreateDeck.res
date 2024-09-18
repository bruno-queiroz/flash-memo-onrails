type newDeck = {title: string}
type postDeckParams = {deck: newDeck}

let create = async (newDeck: postDeckParams) => {
  let params = {
    "method": "POST",
    "headers": {
      "Content-Type": "application/json",
      "Accept": "application/json",
    },
    "body": JSON.stringifyAny(newDeck),
  }

  let response = await Fetch.fetch("/decks", params)
  let data: Fetch.defaultResponse<unit> = await Fetch.json(response)

  switch (data["isOk"]->Nullable.toOption, data["msg"]->Nullable.toOption) {
  | (Some(false), Some(errMsg)) => Exn.raiseError(errMsg)
  | (Some(true), _) => ()
  | _ => Exn.raiseError("something went wrong")
  }

  data
}
