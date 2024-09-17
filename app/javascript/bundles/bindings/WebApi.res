type classList = {toggle: string => unit, add: string => unit, remove: string => unit}

type documentElement = {classList: classList}

type document = {documentElement: documentElement, value: string, focus: unit => unit}

type localStorage = {setItem: (string, string) => unit, getItem: string => option<string>}

type location = {mutable href: string}

type matchMedia = {matches: bool}

type window = {location: location, matchMedia: string => matchMedia}

type event = {preventDefault: unit => unit, animationName: string}

@val external document: document = "document"
@send external toggle: string => unit = "toggle"

@scope("window") @val external localStorage: localStorage = "localStorage"
@send external setItem: (string, string) => unit = "setItem"

@val external window: window = "window"
@send external matchMedia: string => matchMedia = "matchMedia"

@val external event: event = "event"
