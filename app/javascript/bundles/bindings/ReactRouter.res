module BrowserRouter = {
  @react.component @module("react-router-dom")
  external make: (~children: React.element) => React.element = "BrowserRouter"
}

module Routes = {
  @react.component @module("react-router-dom")
  external make: (~children: React.element) => React.element = "Routes"
}

module Route = {
  @react.component @module("react-router-dom")
  external make: (~path: string, ~element: React.element) => React.element = "Route"
}

module Link = {
  @react.component @module("react-router-dom")
  external make: (~children: React.element, ~to: string, ~className: string=?) => React.element =
    "Link"
}

@module("react-router-dom")
external useNavigate: unit => string => unit = "useNavigate"

@module("react-router-dom")
external useParams: unit => 'a = "useParams"
