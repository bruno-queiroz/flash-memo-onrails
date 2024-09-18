@react.component
let make = (~error) => {
  <div className="text-red-500 text-center"> {error->React.string} </div>
}
