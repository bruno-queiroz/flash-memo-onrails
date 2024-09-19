type newCard = {
  deck_id: string,
  front: string,
  back: string,
  ease_factor: float,
  interval: int,
  repetitions: int,
  review_at: Js.Date.t,
}
type postCardParams = {card: newCard}

let post = async (newCard: postCardParams) => {
  let params = {
    "method": "POST",
    "headers": {
      "Content-Type": "application/json",
      "Accept": "application/json",
    },
    "body": JSON.stringifyAny(newCard),
  }

  let response = await Fetch.fetch("/cards", params)
  let data: Fetch.defaultResponse<unit> = await Fetch.json(response)

  switch (data["isOk"]->Nullable.toOption, data["msg"]->Nullable.toOption) {
  | (Some(false), Some(errMsg)) => Exn.raiseError(errMsg)
  | (Some(true), _) => ()
  | _ => Exn.raiseError("something went wrong")
  }

  data
}
