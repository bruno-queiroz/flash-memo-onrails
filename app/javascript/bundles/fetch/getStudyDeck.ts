import { BASE_URL } from "./config";
import { ServerResponse } from "./types";

export const getStudyDeck = async (deckTitle: string) => {
  const response = await fetch(`${BASE_URL}/decks/${deckTitle}`, {
    credentials: "include",
  });
  const data: ServerResponse<any> = await response.json();

  if (!data?.isOk) {
    throw new Error(data.msg);
  }

  return data;
};
