import React from "react";

export const FormErrorMessage = ({
  errorMessage,
}: {
  errorMessage?: string;
}) => {
  return <div className="text-red-500 text-center">{errorMessage}</div>;
};
