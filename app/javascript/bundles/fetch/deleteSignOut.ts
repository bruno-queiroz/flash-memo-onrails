import { BASE_URL } from "./config";

export const deleteSignOut = async () => {
  await fetch(`${BASE_URL}/sign-out.json`, {
    method: "DELETE",
    redirect: "manual",
    credentials: "include",
  });

  window.location.href = "/";
};
