import { SearchCard, ServerResponse } from "./types";

export interface GetSearchedCards {
  deckId: string;
  query: string;
}

export const getSearchedCards = async ({ deckId, query }: GetSearchedCards) => {
  const response = await fetch(
    `http://127.0.0.1:3000/card/${deckId}?q=${query}`,
    {
      credentials: "include",
    }
  );
  const data: ServerResponse<SearchCard[]> = await response.json();

  if (!data?.isOk || data?.data.length === 0) {
    throw new Error(data.msg);
  }

  return data;
};
