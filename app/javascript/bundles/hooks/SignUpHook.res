type t = {
  nameInputRef: ReactDOM.Ref.currentDomRef,
  passwordInputRef: ReactDOM.Ref.currentDomRef,
  isLoading: bool,
  error: string,
  onSubmit: JsxEventU.Form.t => promise<unit>,
}

let useSignUp = () => {
  let (isLoading, setIsLoading) = React.useState(_ => false)
  let (error, setError) = React.useState(_ => "")

  let nameInputRef = React.useRef(Nullable.null)
  let passwordInputRef = React.useRef(Nullable.null)

  let onSubmit = async (e: JsxEventU.Form.t) => {
    let e = (Obj.magic(e): WebApi.event)
    e.preventDefault()

    let inputName = (Obj.magic(nameInputRef.current): WebApi.document)
    let inputPassword = (Obj.magic(passwordInputRef.current): WebApi.document)

    let user: SignUpUser.user = {
      name: inputName.value,
      password: inputPassword.value,
      remember_me: "1",
    }

    try {
      setIsLoading(_ => true)
      let _ = await SignUpUser.post({user: user})
      setIsLoading(_ => false)
    } catch {
    | Exn.Error(obj) =>
      switch Exn.message(obj) {
      | Some(msg) =>
        setIsLoading(_ => false)
        setError(_ => msg)
      | _ =>
        setIsLoading(_ => false)
        setError(_ => "Something went wrong")
      }
    }
  }

  {
    nameInputRef,
    passwordInputRef,
    isLoading,
    error,
    onSubmit,
  }
}
