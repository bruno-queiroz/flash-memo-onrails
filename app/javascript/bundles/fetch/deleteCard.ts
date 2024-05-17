import { ServerResponse } from "./types";

export const deleteCard = async (cardId: string) => {
  const response = await fetch(`http://127.0.0.1:3000/card/${cardId}`, {
    method: "DELETE",
    credentials: "include",
  });
  const data: ServerResponse<null> = await response.json();

  return data;
};
