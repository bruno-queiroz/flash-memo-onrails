@react.component
let make = (~path, ~name) => {
  <ReactRouter.Link to={path}>
    <div
      className="p-3 relative after:h-[2.5px] after:w-[0px] after:bg-dark-blue after:dark:bg-aqua-blue after:absolute after:bottom-0 after:left-0 after:transition-all after:duration-300 hover:after:w-full">
      {name->React.string}
    </div>
  </ReactRouter.Link>
}
