import { useMutation, useQueryClient } from "@tanstack/react-query";

import { PatchCardContent, patchCardContent } from "../fetch/patchCardContent";

import { useAppDispatch } from "../hooks/useAppDispatch";
import { setNotification } from "../global-state/reducers/notificationSlice";
import { useAppSelector } from "../hooks/useAppSelector";
import { setIsEditCardModalOpen } from "../global-state/reducers/cardSlice";
import { useEffect, useRef } from "react";

export const useEditCardModal = (reSearchCards: () => void) => {
  const { isPending: isEditCardLoading, mutateAsync: editCardMutate } =
    useMutation({
      mutationFn: (card: PatchCardContent) => patchCardContent(card),
      onSuccess: () => {
        reSearchCards();
        queryClient.invalidateQueries({ queryKey: ["studyDeck"] });
      },
    });

  const { front, back, cardId } = useAppSelector(
    (state) => state.selectedCard.data
  );
  const isEditCardModalOpen = useAppSelector(
    (state) => state.card.isEditCardModalOpen
  );

  const dispatch = useAppDispatch();

  const cardFrontInputRef = useRef<HTMLTextAreaElement>(null);
  const cardBackInputRef = useRef<HTMLTextAreaElement>(null);
  const queryClient = useQueryClient();

  const editCard = async (event: React.FormEvent<HTMLFormElement>) => {
    event.preventDefault();
    if (!cardFrontInputRef.current && !cardBackInputRef.current) return;

    const card = {
      front: cardFrontInputRef.current.value,
      back: cardBackInputRef.current.value,
    };

    if (card.front === front && card.back === back) {
      dispatch(
        setNotification({
          isShowing: true,
          isOk: true,
          msg: "No changes",
        })
      );

      dispatch(setIsEditCardModalOpen(false));
      return;
    }

    const response = await editCardMutate({ cardId, card });

    dispatch(
      setNotification({
        isShowing: true,
        isOk: response?.isOk,
        msg: response?.msg,
      })
    );

    dispatch(setIsEditCardModalOpen(false));
  };

  const setIsModalOpen = (isOpen: boolean) => {
    dispatch(setIsEditCardModalOpen(isOpen));
  };

  useEffect(() => {
    cardFrontInputRef.current.value = front;
    cardBackInputRef.current.value = back;
  }, [isEditCardModalOpen]);

  return {
    isEditCardModalOpen,
    setIsModalOpen,
    editCard,
    cardFrontInputRef,
    cardBackInputRef,
    isEditCardLoading,
  };
};
