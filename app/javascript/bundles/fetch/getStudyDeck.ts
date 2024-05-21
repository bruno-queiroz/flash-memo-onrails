import { ServerResponse } from "./types";

export const getStudyDeck = async (deckTitle: string) => {
  const response = await fetch(`http://127.0.0.1:3000/deck/${deckTitle}`, {
    credentials: "include",
  });
  const data: ServerResponse<any> = await response.json();

  if (!data?.isOk) {
    throw new Error(data.msg);
  }

  return data;
};
