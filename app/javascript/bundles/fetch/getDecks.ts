import { Deck, ServerResponse } from "./types";

export const getDecks = async () => {
  const response = await fetch("http://127.0.0.1:3000/decks-data.json", {
    credentials: "include",
  });
  const data: ServerResponse<Deck[]> = await response.json();

  if (!data?.isOk) {
    throw data.msg;
  }

  return data;
};
