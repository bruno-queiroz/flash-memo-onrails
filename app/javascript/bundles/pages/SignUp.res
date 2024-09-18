@react.component
let make = () => {
  let {nameInputRef, passwordInputRef, isLoading, error, onSubmit} = SignUpHook.useSignUp()

  <section className="flex flex-col items-center justify-center p-4">
    <h1 className="text-4xl font-bold my-8 dark:text-white text-neutral-800 text-center">
      {"Sign Up"->React.string}
    </h1>
    <Form
      onSubmit={event => {
        let _ = onSubmit(event)
      }}>
      <Input labelText="Your Name" required=true type_="text" ref={nameInputRef} autoFocus=true />
      <Input
        labelText="Create your password" required=true type_="password" ref={passwordInputRef}
      />
      <button
        className="bg-primary-yellow py-2 px-4 rounded w-[max-content] mx-auto mt-4 text-white font-semibold">
        {isLoading ? <LoadSpinner /> : "Sign Up"->React.string}
      </button>
      <FormErrorMessage error={error} />
      <a href="/sign-in" className="text-center dark:text-gray-300 ">
        {"Already have an account? click here"->React.string}
      </a>
    </Form>
  </section>
}
