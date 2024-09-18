let params = {
  "method": "DELETE",
  "redirect": "manual",
  "credentials": "include",
  "headers": {
    "Content-Type": "application/json",
    "Accept": "application/json",
  },
}

let delete = async () => {
  let _ = await Fetch.fetch("/sign-out", params)

  WebApi.window.location.href = "/"
}
