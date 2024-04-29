import React from "react";
import { FormError } from "../hooks/useSignUp";
import { formatErrors } from "../utils/formatErrors";

interface FormErrorMessageProps {
  error: FormError;
}

export const FormErrorMessage = ({ error }: FormErrorMessageProps) => {
  const errors = formatErrors(error);
  return errors.map((errorMsg) => {
    return <div className="text-red-500 text-center">{errorMsg}</div>;
  });
};
