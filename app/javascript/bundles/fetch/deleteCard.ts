import { BASE_URL } from "./config";
import { ServerResponse } from "./types";

export const deleteCard = async (cardId: string) => {
  const response = await fetch(`${BASE_URL}/cards/${cardId}`, {
    method: "DELETE",
    credentials: "include",
  });
  const data: ServerResponse<null> = await response.json();

  return data;
};
