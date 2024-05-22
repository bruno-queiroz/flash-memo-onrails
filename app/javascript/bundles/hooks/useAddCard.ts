import React, { useRef } from "react";

import { useMutation, useQuery, useQueryClient } from "@tanstack/react-query";

import { getDecks } from "../fetch/getDecks";
import { CreateCard, createCard } from "../fetch/createCard";

import { useAppDispatch } from "../hooks/useAppDispatch";
import { setNotification } from "../global-state/reducers/notificationSlice";

export const useAddCard = () => {
  const { data: decks } = useQuery({
    queryKey: ["decksData"],
    queryFn: getDecks,
  });

  const queryClient = useQueryClient();

  const { mutateAsync: cardMutate, isPending } = useMutation({
    mutationFn: (newCard: CreateCard) => createCard(newCard),
    onSuccess: () => queryClient.invalidateQueries({ queryKey: ["decksData"] }),
  });

  const dispatch = useAppDispatch();

  const cardSelectRef = useRef<HTMLSelectElement>(null);
  const cardFrontInputRef = useRef<HTMLTextAreaElement>(null);
  const cardBackInputRef = useRef<HTMLTextAreaElement>(null);

  const submitCard = async (event: React.FormEvent<HTMLFormElement>) => {
    event.preventDefault();
    const defaults = {
      ease_factor: 1.7,
      interval: 0,
      repetitions: 0,
      review_at: new Date(1970),
    };
    const newCard = {
      card: {
        deck_id: cardSelectRef.current?.value,
        front: cardFrontInputRef.current?.value,
        back: cardBackInputRef.current?.value,
        ...defaults,
      },
    };

    try {
      const response = await cardMutate(newCard);
      dispatch(
        setNotification({
          isShowing: true,
          isOk: true,
          msg: response.msg,
        })
      );

      cardFrontInputRef.current.value = "";
      cardBackInputRef.current.value = "";
    } catch (err) {
      dispatch(
        setNotification({
          isShowing: true,
          isOk: false,
          msg: err,
        })
      );
    }
  };

  return {
    submitCard,
    cardSelectRef,
    decks,
    cardFrontInputRef,
    cardBackInputRef,
    isPending,
  };
};
