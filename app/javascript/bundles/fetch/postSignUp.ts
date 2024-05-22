import { BASE_URL } from "./config";
import { User } from "./types";

export interface UserForm {
  user: {
    name: string;
    password: string;
  };
}

export const postSignUp = async (user: UserForm) => {
  const response = await fetch(`${BASE_URL}/sign-up.json`, {
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
