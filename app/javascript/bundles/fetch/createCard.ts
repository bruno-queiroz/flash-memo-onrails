import { ServerResponse } from "./types";

export interface CreateCard {
  card: {
    deck_id: string;
    front: string;
    back: string;
    ease_factor: number;
    interval: number;
    repetitions: number;
  };
}
export const createCard = async (newCard: CreateCard) => {
  const response = await fetch("http://127.0.0.1:3000/cards", {
    method: "POST",
    headers: {
      "Content-Type": "application/json",
    },
    body: JSON.stringify(newCard),
    credentials: "include",
  });
  const data: ServerResponse<null> = await response.json();

  if (!data?.isOk) {
    throw data.msg;
  }

  return data;
};
