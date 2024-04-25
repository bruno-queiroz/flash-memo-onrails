import React, { useRef } from "react";

import { Form } from "../components/Form";
import { Input } from "../components/Input";
// import { useMutation } from "react-query";
// import { postSignUp } from "../fetch/postSignUp";
import { FormErrorMessage } from "../components/FormErrorMessage";
import { LoadSpinner } from "../components/LoadSpinner";

export interface UserForm {
  name: string;
  password: string;
}

export const SignUp = () => {
  const nameInputRef = useRef<HTMLInputElement>(null);
  const passwordInputRef = useRef<HTMLInputElement>(null);
  //   const {
  //     mutateAsync: newUserMutation,
  //     isLoading,
  //     error,
  //   } = useMutation((user: UserForm) => postSignUp(user));

  const onSubmit = async (e: React.FormEvent<HTMLFormElement>) => {
    e.preventDefault();

    if (nameInputRef.current && passwordInputRef.current) {
      const newUser = {
        name: nameInputRef.current?.value,
        password: passwordInputRef.current?.value,
      };

      try {
        // await newUserMutation(newUser);
      } catch (err) {
        console.log(err);
      }
    }
  };

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
          {false ? <LoadSpinner /> : "Sign Up"}
        </button>
        <FormErrorMessage errorMessage={({} as Error)?.message} />
        <a href="/users/sign_in" className="text-center dark:text-gray-300 ">
          Already have an account? click here
        </a>
      </Form>
    </section>
  );
};
