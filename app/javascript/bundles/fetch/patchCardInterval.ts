import { Card, ServerResponse } from "./types";

export const patchCardInterval = async ({
  id,
  ease_factor,
  interval,
  is_reset,
  repetitions,
}: Card) => {
  const response = await fetch(`http://127.0.0.1:3000/card/interval/${id}`, {
    method: "PATCH",
    headers: {
      "Content-Type": "application/json",
    },
    body: JSON.stringify({
      card: { ease_factor, interval, is_reset, repetitions },
    }),
    credentials: "include",
  });

  const data: ServerResponse<null> = await response.json();

  if (!data?.isOk) {
    throw data.msg;
  }

  return data;
};
