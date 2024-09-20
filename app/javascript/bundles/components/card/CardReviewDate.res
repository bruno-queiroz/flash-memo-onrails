@react.component
let make = (~review_at: Js.Date.t) => {
  let currentDate = Js.Date.make()
  let reviewDate = WebApi.dateFromJsDate(review_at)

  let isCardAvailable = reviewDate < currentDate

  if isCardAvailable {
    <span> {" available"->React.string} </span>
  } else {
    <span> {WebApi.formatDistanceToNow(review_at)->React.string} </span>
  }
}
