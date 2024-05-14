import { ServerResponse } from "./types";

export const deleteDeck = async (deckId: string) => {
  const response = await fetch(`http://127.0.0.1:3000/deck/${deckId}`, {
    method: "DELETE",
    credentials: "include",
  });
  const data: ServerResponse<null> = await response.json();

  if (!data?.isOk) {
    throw data.msg;
  }

  return data;
};
