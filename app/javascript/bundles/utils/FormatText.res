let format = (text: string) => {
  let regex = Js.Re.fromString("\\n")
  let textSplittedOnNewLines = Js.String.splitByRe(regex, text)
  textSplittedOnNewLines
}
