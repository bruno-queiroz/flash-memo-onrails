let patch = async ({id, ease_factor, interval, is_reset, repetitions}: Types.card) => {
  let params = {
    "method": "PATCH",
    "headers": {
      "Content-Type": "application/json",
      "Accept": "application/json",
    },
    "body": JSON.stringifyAny({
      "card": {
        "ease_factor": ease_factor,
        "interval": interval,
        "is_reset": is_reset,
        "repetitions": repetitions,
      },
    }),
  }

  let response = await Fetch.fetch(`/cards/interval/${id}`, params)
  let data: Fetch.defaultResponse<Types.card> = await Fetch.json(response)

  switch (data["isOk"]->Nullable.toOption, data["msg"]->Nullable.toOption) {
  | (Some(false), Some(errMsg)) => Exn.raiseError(errMsg)
  | (Some(true), _) => ()
  | _ => Exn.raiseError("something went wrong")
  }

  let data = (Obj.magic(data): Types.response<Types.card>)
  data
}
