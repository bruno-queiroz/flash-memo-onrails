import React, { useRef, useState } from "react";
import { postSignUp } from "../fetch/postSignUp";

export interface FormError {
  [key: string]: string[];
}

export const useSignUp = () => {
  const [isLoading, setIsLoading] = useState(false);
  const [error, setError] = useState<FormError>({} as FormError);

  const nameInputRef = useRef<HTMLInputElement>(null);
  const passwordInputRef = useRef<HTMLInputElement>(null);

  const onSubmit = async (e: React.FormEvent<HTMLFormElement>) => {
    e.preventDefault();

    if (nameInputRef.current && passwordInputRef.current) {
      const user = {
        name: nameInputRef.current?.value,
        password: passwordInputRef.current?.value,
      };

      setIsLoading(true);
      const response = await postSignUp({ user });
      setIsLoading(false);

      if (!response.isOk) {
        if (Object.keys(response.errors).length === 0) {
          setError({ Error: ["something went wrong"] });
        }
        setError(response.errors);
      }
    }
  };

  return {
    nameInputRef,
    passwordInputRef,
    isLoading,
    error,
    onSubmit,
  };
};
