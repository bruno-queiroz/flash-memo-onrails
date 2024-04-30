import React, { useRef, useState } from "react";
import { postSignIn } from "../fetch/postSignIn";

export interface FormError {
  [key: string]: string[];
}

export const useSignIn = () => {
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
        remember_me: "1" as const,
      };

      setIsLoading(true);
      const response = await postSignIn({ user });
      setIsLoading(false);

      if (!response?.id) {
        console.log("add error");
        if (Object.keys(response.errors || {}).length === 0) {
          setError({ Error: ["something went wrong"] });
        }
        setError(response);
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
