type user = {name: string, password: string, remember_me: string}

type signUp = {user: user}

let post = async (user: signUp) => {
  let params = {
    "method": "POST",
    "headers": {
      "Content-Type": "application/json",
      "Accept": "application/json",
    },
    "body": JSON.stringifyAny(user),
  }

  let response = await Fetch.fetch("http://127.0.0.1:3000/sign-up", params)
  let data = await Fetch.json(response)

  switch (data["id"]->Nullable.toOption, data["error"]->Nullable.toOption) {
  | (Some(_), _) => ()
  | (_, Some(error)) => Exn.raiseError(error)
  | _ => Exn.raiseError("Something went wrong")
  }

  WebApi.window.location.href = "/decks"
}
