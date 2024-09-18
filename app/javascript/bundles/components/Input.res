@react.component
let make = React.forwardRef((
  ~labelText: string,
  ~isSecondVariant: option<bool>=?,
  ~autoFocus: option<bool>=?,
  ~type_: option<string>=?,
  ~required=false,
  ref,
) => {
  let className = switch isSecondVariant {
  | Some(true) => "dark:bg-neutral-700 bg-gray-200"
  | _ => "dark:bg-neutral-800"
  }

  <label className="flex flex-col gap-2">
    <span className="dark:text-gray-300 text-black"> {React.string(labelText)} </span>
    <input
      ref=?{Nullable.toOption(ref)->Option.map(ReactDOM.Ref.domRef)}
      required
      ?autoFocus
      ?type_
      className={className ++ " p-2 dark:text-gray-300"}
    />
  </label>
})
