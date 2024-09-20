@react.component
let make = (~error: ReactQuery.error) => {
  <div className="grid place-items-center bg-gray-200 dark:bg-neutral-900 rounded p-4">
    {error.message->React.string}
  </div>
}
