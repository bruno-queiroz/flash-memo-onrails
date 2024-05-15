import { useEffect, useRef } from "react";

import { setIsCreateDeckModalOpen } from "../global-state/reducers/deckSlice";
import { setNotification } from "../global-state/reducers/notificationSlice";

import { useAppDispatch } from "../hooks/useAppDispatch";
import { useAppSelector } from "../hooks/useAppSelector";

import { useMutation, useQueryClient } from "@tanstack/react-query";
import { postDeck, PostDeckParams } from "../fetch/postDeck";

const DIALOG_ANIMATION_TIME = 150;

export const useCreateDeckModal = () => {
  const deckNameRef = useRef<HTMLInputElement>(null);
  const queryClient = useQueryClient();
  const isCreateDeckModalOpen = useAppSelector(
    (state) => state.deck.isCreateDeckModalOpen
  );
  const dispatch = useAppDispatch();

  const setIsModalOpen = (isOpen: boolean) => {
    dispatch(setIsCreateDeckModalOpen(isOpen));
  };

  const { mutateAsync: createDeckMutate, isPending } = useMutation({
    mutationFn: (newDeck: PostDeckParams) => postDeck(newDeck),
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ["decksData"] });
    },
  });

  const createDeck = async (event: React.FormEvent<HTMLFormElement>) => {
    event.preventDefault();

    const newDeck = {
      deck: {
        title: deckNameRef.current.value,
      },
    };
    try {
      const data = await createDeckMutate(newDeck);
      dispatch(
        setNotification({
          isShowing: true,
          isOk: true,
          msg: data?.msg,
        })
      );
      dispatch(setIsCreateDeckModalOpen(false));
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

  useEffect(() => {
    if (isCreateDeckModalOpen && deckNameRef.current) {
      deckNameRef.current.value = "";
      setTimeout(() => {
        deckNameRef.current?.focus();
      }, DIALOG_ANIMATION_TIME);
    }
  }, [isCreateDeckModalOpen]);

  return {
    isCreateDeckModalOpen,
    setIsModalOpen,
    createDeck,
    deckNameRef,
    isPending,
  };
};
