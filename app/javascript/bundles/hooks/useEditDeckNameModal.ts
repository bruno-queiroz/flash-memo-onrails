import { useEffect, useRef } from "react";
import { useMutation, useQueryClient } from "@tanstack/react-query";
import { RenameDeckParams, patchRenameDeck } from "../fetch/patchRenameDeck";
import { useAppSelector } from "../hooks/useAppSelector";
import { useAppDispatch } from "../hooks/useAppDispatch";
import { setIsEditDeckNameModalOpen } from "../global-state/reducers/deckSlice";
import { setNotification } from "../global-state/reducers/notificationSlice";

export const useEditDeckNameModal = () => {
  const deckNameInputRef = useRef<HTMLInputElement>(null);

  const dispatch = useAppDispatch();

  const isEditDeckNameModalOpen = useAppSelector(
    (state) => state.deck.isEditDeckNameModalOpen
  );
  const selectedDeckId = useAppSelector(
    (state) => state.selectedDeck.data.deckId
  );
  const selectedDeckTitle = useAppSelector(
    (state) => state.selectedDeck.data.deckTitle
  );

  const queryClient = useQueryClient();
  const { mutateAsync: renameDeckMutate } = useMutation({
    mutationFn: (data: RenameDeckParams) => patchRenameDeck(data),
    onSuccess: () => queryClient.invalidateQueries({ queryKey: ["decksData"] }),
  });

  const setIsModalOpen = (isOpen: boolean) => {
    dispatch(setIsEditDeckNameModalOpen(isOpen));
  };

  const onEditDeckName = async (event: React.FormEvent<HTMLFormElement>) => {
    event.preventDefault();
    if (!deckNameInputRef.current) return;

    try {
      const data = await renameDeckMutate({
        deckId: selectedDeckId,
        deckTitle: deckNameInputRef.current.value,
      });
      dispatch(
        setNotification({
          isShowing: true,
          isOk: true,
          msg: data?.msg,
        })
      );
      dispatch(setIsEditDeckNameModalOpen(false));
    } catch (err) {
      setNotification({
        isShowing: true,
        isOk: false,
        msg: err,
      });
    }
  };

  useEffect(() => {
    if (deckNameInputRef.current && selectedDeckTitle) {
      deckNameInputRef.current.value = selectedDeckTitle;
    }
  }, [selectedDeckTitle]);

  return {
    isEditDeckNameModalOpen,
    setIsModalOpen,
    onEditDeckName,
    deckNameInputRef,
  };
};
