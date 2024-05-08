import { FormError } from "../hooks/useSignUp";

export const formatErrors = (errors: FormError) => {
  return Object.keys(errors || {}).map((key) => `${key}: ${errors[key]}`);
};
