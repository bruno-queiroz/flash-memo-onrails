import { useEffect, useState } from "react";

import { setSelectedDeck } from "../global-state/reducers/selectedDeckSlice";
import {
  setIsDeleteDeckModalOpen,
  setIsEditDeckNameModalOpen,
} from "../global-state/reducers/deckSlice";

import { useAppDispatch } from "../hooks/useAppDispatch";
import { useAppSelector } from "./useAppSelector";

export const useDeckStatus = (title: string, id: string) => {
  const [isOptionsActive, setIsOptionsActive] = useState(false);

  const dispatch = useAppDispatch();
  const deckId = useAppSelector((state) => state.selectedDeck.data.deckId);

  const openDeckOptions = () => {
    setIsOptionsActive(!isOptionsActive);
    dispatch(setSelectedDeck({ deckId: id, deckTitle: title }));
  };

  const openDeleteDeckModal = () => {
    dispatch(setIsDeleteDeckModalOpen(true));
  };

  const openEditNameDeckModal = () => {
    dispatch(setIsEditDeckNameModalOpen(true));
  };

  useEffect(() => {
    const body = document.querySelector("body");

    const listener = (event: MouseEvent) => {
      const isTheOptionClicked =
        id === deckId && (event.target as HTMLDivElement).id === "deck-option";

      if (isTheOptionClicked) return;

      setIsOptionsActive(false);
    };

    body?.addEventListener("click", listener);

    return () => body?.removeEventListener("click", listener);
  }, [deckId]);

  // const checkDeckCardsAvailability = (
  //   e: React.MouseEvent<HTMLAnchorElement, MouseEvent>
  // ) => {
  //   if (!cards.newCards && !cards.resetedCards && !cards.reviewCards) {
  //     e.preventDefault();
  //     setNotificationContent({
  //       isNotificationShowing: true,
  //       isOk: false,
  //       msg: "No Cards to Study in this deck",
  //     });
  //   }
  // };
  return {
    openDeckOptions,
    isOptionsActive,
    openDeleteDeckModal,
    openEditNameDeckModal,
  };
};
