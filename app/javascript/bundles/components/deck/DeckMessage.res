type deckMessage = {message: string}

@react.component
let make = (~message) => {
  <div
    className="dark:bg-neutral-900 shadow-md bg-gray-200 px-4 py-8 rounded w-full text-center mx-auto">
    {message->React.string}
  </div>
}
