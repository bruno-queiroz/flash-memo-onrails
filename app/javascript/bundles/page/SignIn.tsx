import React from "react";

import { Form } from "../components/Form";
import { Input } from "../components/Input";
import { FormErrorMessage } from "../components/FormErrorMessage";
import { LoadSpinner } from "../components/LoadSpinner";
import { useSignIn } from "../hooks/useSignIn";

export const SignIn = () => {
  const { nameInputRef, passwordInputRef, isLoading, error, onSubmit } =
    useSignIn();

  return (
    <section className="flex flex-col items-center justify-center p-4">
      <h1 className="text-4xl font-bold my-8 dark:text-white text-neutral-800 text-center">
        Sign In
      </h1>

      <Form onSubmit={onSubmit}>
        <Input labelText="Your Name" required ref={nameInputRef} autoFocus />
        <Input
          labelText="Your Password"
          type="password"
          required
          ref={passwordInputRef}
        />
        <button className="bg-primary-yellow py-2 px-4 min-w-[80px] rounded w-[max-content] mx-auto mt-4 text-white font-semibold">
          {isLoading ? <LoadSpinner /> : "Sign In"}
        </button>
        <FormErrorMessage error={error} />
        <a href="/sign_up" className="text-center dark:text-gray-300 ">
          Don't have an account? click here
        </a>
      </Form>
    </section>
  );
};
