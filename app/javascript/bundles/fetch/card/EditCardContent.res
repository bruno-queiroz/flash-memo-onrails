type card = {
  front: string,
  back: string,
}

type editCardContent = {
  cardId: string,
  card: card,
}

let patch = async ({cardId, card}: editCardContent) => {
  let params = {
    "method": "PATCH",
    "headers": {
      "Content-Type": "application/json",
      "Accept": "application/json",
    },
    "body": JSON.stringifyAny({
      "card": card,
    }),
  }

  let response = await Fetch.fetch(`/cards/${cardId}`, params)
  let data: Fetch.defaultResponse<unit> = await Fetch.json(response)

  switch (data["isOk"]->Nullable.toOption, data["msg"]->Nullable.toOption) {
  | (Some(false), Some(errMsg)) => Exn.raiseError(errMsg)
  | (Some(true), _) => ()
  | _ => Exn.raiseError("something went wrong")
  }

  let data = (Obj.magic(data): Types.response<unit>)
  data
}
