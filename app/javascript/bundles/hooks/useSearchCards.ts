import { useRef } from "react";

import { useMutation, useQuery } from "@tanstack/react-query";
import { GetSearchedCards, getSearchedCards } from "../fetch/getSearchedCards";
import { getDecks } from "../fetch/getDecks";

export const useSearchCards = () => {
  const deckSelectRef = useRef<HTMLSelectElement>(null);
  const searchInputRef = useRef<HTMLInputElement>(null);

  const { data, isError, error, isPending, mutate } = useMutation({
    mutationFn: (data: GetSearchedCards) => getSearchedCards(data),
  });

  const { data: decks } = useQuery({
    queryFn: getDecks,
    queryKey: ["decksData"],
  });

  const onSearch = async (event: React.FormEvent<HTMLFormElement>) => {
    event.preventDefault();
    mutate({
      deckId: deckSelectRef.current?.value,
      query: searchInputRef.current?.value,
    });
  };

  return {
    onSearch,
    deckSelectRef,
    decks,
    searchInputRef,
    isPending,
    isError,
    error,
    data,
  };
};
