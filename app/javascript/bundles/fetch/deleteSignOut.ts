export const deleteSignOut = async () => {
  await fetch(`http://127.0.0.1:3000/sign-out.json`, {
    method: "DELETE",
    redirect: "manual",
    credentials: "include",
  });

  window.location.href = "/";
};
