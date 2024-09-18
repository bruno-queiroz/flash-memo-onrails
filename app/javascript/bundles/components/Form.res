@react.component
let make = (~onSubmit, ~children) => {
  <form
    className="flex flex-col w-full gap-4 max-w-[600px] p-4 rounded bg-gray-200 shadow-md dark:bg-neutral-900"
    onSubmit>
    {children}
  </form>
}
