type getSearchedCards = {
  deckId: string,
  query: string,
}

type t = {
  front: string,
  back: string,
  id: string,
  review_at: Js.Date.t,
}

let params = {
  "method": "GET",
  "headers": {
    "Content-Type": "application/json",
    "Accept": "application/json",
  },
}
let get = async ({query, deckId}: getSearchedCards) => {
  let response = await Fetch.fetch(`/cards/${deckId}?q=${query}`, params)
  let data: Fetch.defaultResponse<array<t>> = await Fetch.json(response)

  switch (data["isOk"]->Nullable.toOption, data["msg"]->Nullable.toOption) {
  | (Some(false), Some(errMsg)) => Exn.raiseError(errMsg)
  | (Some(true), _) => ()
  | _ => Exn.raiseError("something went wrong")
  }

  let data = (Obj.magic(data): Types.response<t>)
  data
}
