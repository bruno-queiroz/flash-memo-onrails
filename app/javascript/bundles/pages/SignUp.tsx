import React from "react";

import { Form } from "../components/Form";
import { Input } from "../components/Input";
import { FormErrorMessage } from "../components/FormErrorMessage";
import { LoadSpinner } from "../components/LoadSpinner";
import { useSignUp } from "../hooks/useSignUp";

export const SignUp = () => {
  const { nameInputRef, passwordInputRef, isLoading, error, onSubmit } =
    useSignUp();

  return (
    <section className="flex flex-col items-center justify-center p-4">
      <h1 className="text-4xl font-bold my-8 dark:text-white text-neutral-800 text-center">
        Sign Up
      </h1>
      <Form onSubmit={onSubmit}>
        <Input
          labelText="Your Name"
          required
          type="text"
          ref={nameInputRef}
          autoFocus
        />
        <Input
          labelText="Create your password"
          required
          type="password"
          ref={passwordInputRef}
        />

        <button className="bg-primary-yellow py-2 px-4 rounded w-[max-content] mx-auto mt-4 text-white font-semibold">
          {isLoading ? <LoadSpinner /> : "Sign Up"}
        </button>
        <FormErrorMessage error={error} />
        <a href="/sign-in" className="text-center dark:text-gray-300 ">
          Already have an account? click here
        </a>
      </Form>
    </section>
  );
};
