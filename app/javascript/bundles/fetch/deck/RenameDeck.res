type renameDeck = {
  deckId: string,
  deckTitle: string,
}

let patch = async (deck: renameDeck) => {
  let params = {
    "method": "PATCH",
    "headers": {
      "Content-Type": "application/json",
      "Accept": "application/json",
    },
    "body": JSON.stringifyAny({
      "deck": {
        "title": deck.deckTitle,
      },
    }),
  }

  let response = await Fetch.fetch(`/decks/${deck.deckId}`, params)
  let data: Fetch.defaultResponse<unit> = await Fetch.json(response)

  switch (data["isOk"]->Nullable.toOption, data["msg"]->Nullable.toOption) {
  | (Some(false), Some(errMsg)) => Exn.raiseError(errMsg)
  | (Some(true), _) => ()
  | _ => Exn.raiseError("something went wrong")
  }

  data
}
