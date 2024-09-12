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
