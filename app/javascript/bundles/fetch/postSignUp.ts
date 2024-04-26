import { ServerResponse } from "./types";

export interface UserForm {
  user: {
    name: string;
    password: string;
  };
}

export const postSignUp = async (user: UserForm) => {
  const response = await fetch(`http://127.0.0.1:3000/users`, {
    method: "POST",
    redirect: "manual",
    headers: {
      "Content-Type": "application/json",
    },
    body: JSON.stringify(user),
    credentials: "include",
  });
  const data: ServerResponse<any> = await response.json();

  if (data.isOk) {
    window.location.href = "/";
  }
  return data;
};
