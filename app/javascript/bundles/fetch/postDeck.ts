import { BASE_URL } from "./config";
import { ServerResponse } from "./types";

export interface PostDeckParams {
  deck: {
    title: string;
  };
}
export const postDeck = async (newDeck: PostDeckParams) => {
  const response = await fetch(`${BASE_URL}/decks`, {
    method: "POST",
    headers: {
      "Content-Type": "application/json",
    },
    body: JSON.stringify(newDeck),
    credentials: "include",
  });
  const data: ServerResponse<null> = await response.json();

  if (!data?.isOk) {
    throw data.msg;
  }

  return data;
};
