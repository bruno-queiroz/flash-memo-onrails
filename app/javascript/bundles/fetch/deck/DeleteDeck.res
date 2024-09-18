let delete = async (deckId: string) => {
  let params = {
    "method": "DELETE",
    "headers": {
      "Content-Type": "application/json",
      "Accept": "application/json",
    },
  }

  let response = await Fetch.fetch(`/decks/${deckId}`, params)
  let data: Fetch.defaultResponse<unit> = await Fetch.json(response)

  switch (data["isOk"]->Nullable.toOption, data["msg"]->Nullable.toOption) {
  | (Some(false), Some(errMsg)) => Exn.raiseError(errMsg)
  | (Some(true), _) => ()
  | _ => Exn.raiseError("something went wrong")
  }

  data
}
