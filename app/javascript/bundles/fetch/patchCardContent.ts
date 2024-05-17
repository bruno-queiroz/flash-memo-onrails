import { ServerResponse } from "./types";

export interface PatchCardContent {
  cardId: string;
  card: {
    front: string;
    back: string;
  };
}

export const patchCardContent = async ({ cardId, card }: PatchCardContent) => {
  const response = await fetch(`http://127.0.0.1:3000/card/${cardId}`, {
    method: "PATCH",
    headers: {
      "Content-Type": "application/json",
    },
    body: JSON.stringify({
      card,
    }),
    credentials: "include",
  });

  const data: ServerResponse<null> = await response.json();

  return data;
};
