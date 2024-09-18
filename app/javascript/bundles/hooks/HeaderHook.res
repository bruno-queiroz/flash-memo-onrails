type t = {
  isNavActive: bool,
  isDarkMode: bool,
  isLoggingOut: bool,
  setIsNavActive: (bool => bool) => unit,
  changeTheme: unit => unit,
  logOut: unit => promise<unit>,
}

let useHeader = (isUserSignedIn: bool) => {
  let (isLoggingOut, setIsLoggingOut) = React.useState(() => false)
  let (isNavActive, setIsNavActive) = React.useState(() => false)
  let (isDarkMode, setIsDarkMode) = React.useState(() => true)

  let changeTheme = () => {
    WebApi.document.documentElement.classList.toggle("dark")
    WebApi.localStorage.setItem("theme", !isDarkMode ? "dark" : "light")
    setIsDarkMode(_ => !isDarkMode)
  }

  let logOut = async () => {
    setIsLoggingOut(_ => false)
    let _ = await SignOutUser.delete()
    setIsLoggingOut(_ => true)
  }

  let redirectIfNotLogged = () => {
    let isSignInPage = WebApi.window.location.href->String.endsWith("/sign-in")
    let isSignUpPage = WebApi.window.location.href->String.endsWith("/sign-up")
    let isHomePage = WebApi.window.location.href->String.endsWith("/")

    switch [isSignInPage, isSignUpPage, isHomePage] {
    | [true, _, _] => ()
    | [_, true, _] => ()
    | [_, _, true] => ()
    | _ => WebApi.window.location.href = "/"
    }
  }

  React.useEffect(() => {
    if !isUserSignedIn {
      redirectIfNotLogged()
    }
    None
  }, [isUserSignedIn])

  React.useEffect(() => {
    let getTheme = WebApi.localStorage.getItem("theme")
    let isDarkPreferred = WebApi.window.matchMedia("(prefers-color-scheme: dark)").matches

    switch (getTheme, isDarkPreferred) {
    | (Some("dark"), _) => {
        WebApi.document.documentElement.classList.add("dark")
        setIsDarkMode(_ => true)
      }
    | (None, true) => {
        WebApi.document.documentElement.classList.add("dark")
        setIsDarkMode(_ => true)
      }
    | _ => {
        WebApi.document.documentElement.classList.remove("dark")
        setIsDarkMode(_ => false)
      }
    }

    None
  }, [])

  {
    isNavActive,
    isDarkMode,
    isLoggingOut,
    setIsNavActive,
    changeTheme,
    logOut,
  }
}
