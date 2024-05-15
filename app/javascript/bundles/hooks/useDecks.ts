import { useQuery } from "@tanstack/react-query";
import { getDecks } from "../fetch/getDecks";
import { useAppDispatch } from "./useAppDispatch";
import { setIsCreateDeckModalOpen } from "../global-state/reducers/deckSlice";

export const useDecks = () => {
  const {
    data: decks,
    isError,
    isPending,
  } = useQuery({ queryKey: ["decksData"], queryFn: getDecks });

  const dispatch = useAppDispatch();

  const openCreateDeckModal = () => {
    dispatch(setIsCreateDeckModalOpen(true));
  };

  return {
    isPending,
    isError,
    decks,
    openCreateDeckModal,
  };
};
