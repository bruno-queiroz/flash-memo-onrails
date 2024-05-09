import { User } from "./types";

export interface UserForm {
  user: {
    name: string;
    password: string;
    remember_me: "1" | "0";
  };
}

export const postSignIn = async (user: UserForm) => {
  const response = await fetch(`http://127.0.0.1:3000/sign-in.json`, {
    method: "POST",
    redirect: "manual",
    headers: {
      "Content-Type": "application/json",
    },
    body: JSON.stringify(user),
    credentials: "include",
  });
  const data: User = await response.json();

  if (!data?.id) {
    throw data;
  }

  window.location.href = "/";
};
