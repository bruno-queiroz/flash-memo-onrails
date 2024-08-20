import { BASE_URL } from "./config";
import { ServerResponse } from "./types";

export interface RenameDeckParams {
  deckId: string;
  deckTitle: string;
}

export const patchRenameDeck = async ({
  deckId,
  deckTitle,
}: RenameDeckParams) => {
  const response = await fetch(`${BASE_URL}/decks/${deckId}`, {
    method: "PATCH",
    headers: {
      "Content-Type": "application/json",
    },
    body: JSON.stringify({
      deck: { title: deckTitle },
    }),
    credentials: "include",
  });

  const data: ServerResponse<null> = await response.json();

  if (!data?.isOk) {
    throw data.msg;
  }

  return data;
};
