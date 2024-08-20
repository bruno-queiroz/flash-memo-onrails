import { BASE_URL } from "./config";
import { SearchCard, ServerResponse } from "./types";

export interface GetSearchedCards {
  deckId: string;
  query: string;
}

export const getSearchedCards = async ({ deckId, query }: GetSearchedCards) => {
  const response = await fetch(`${BASE_URL}/cards/${deckId}?q=${query}`, {
    credentials: "include",
  });
  const data: ServerResponse<SearchCard[]> = await response.json();

  if (!data?.isOk || data?.data.length === 0) {
    throw new Error(data.msg);
  }

  return data;
};
