import { BASE_URL } from "./config";
import { ServerResponse } from "./types";

export const deleteDeck = async (deckId: string) => {
  const response = await fetch(`${BASE_URL}/decks/${deckId}`, {
    method: "DELETE",
    credentials: "include",
  });
  const data: ServerResponse<null> = await response.json();

  if (!data?.isOk) {
    throw data.msg;
  }

  return data;
};
