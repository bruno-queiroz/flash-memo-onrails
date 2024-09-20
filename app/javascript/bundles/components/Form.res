@react.component
let make = (~onSubmit, ~children, ~className="") => {
  <form
    className={`flex flex-col w-full gap-4 max-w-[600px] p-4 rounded bg-gray-200 shadow-md dark:bg-neutral-900 ${className}`}
    onSubmit>
    {children}
  </form>
}
