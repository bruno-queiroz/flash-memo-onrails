import { BASE_URL } from "./config";
import { Deck, ServerResponse } from "./types";

export const getDecks = async () => {
  const response = await fetch(`${BASE_URL}/decks/data.json`, {
    credentials: "include",
  });
  const data: ServerResponse<Deck[]> = await response.json();

  if (!data?.isOk) {
    throw data.msg;
  }

  return data;
};
