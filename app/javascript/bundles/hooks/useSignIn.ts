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

      try {
        setIsLoading(true);
        await postSignIn({ user });
        setIsLoading(false);
      } catch (err) {
        setIsLoading(false);

        if (Object.keys(err?.errors || {}).length === 0) {
          setError({ Error: ["Something went wrong."] });
        }
        setError(err?.errors);
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
