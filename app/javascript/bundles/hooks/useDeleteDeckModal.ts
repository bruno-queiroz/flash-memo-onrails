import { setIsDeleteDeckModalOpen } from "../global-state/reducers/deckSlice";
import { setNotification } from "../global-state/reducers/notificationSlice";

import { useMutation, useQueryClient } from "@tanstack/react-query";
import { deleteDeck } from "../fetch/deleteDeck";

import { useAppSelector } from "../hooks/useAppSelector";
import { useAppDispatch } from "../hooks/useAppDispatch";

export const useDeckDeleteModal = () => {
  const isDeleteDeckModalOpen = useAppSelector(
    (state) => state.deck.isDeleteDeckModalOpen
  );
  const selectedDeckId = useAppSelector(
    (state) => state.selectedDeck.data.deckId
  );
  const selectedDeckTitle = useAppSelector(
    (state) => state.selectedDeck.data.deckTitle
  );

  const dispatch = useAppDispatch();
  const setIsModalOpen = (isOpen: boolean) => {
    dispatch(setIsDeleteDeckModalOpen(isOpen));
  };

  const queryClient = useQueryClient();

  const { mutateAsync: deleteDeckMutate, isPending } = useMutation({
    mutationFn: (deckId: string) => deleteDeck(deckId),
    onSuccess: () => queryClient.invalidateQueries({ queryKey: ["decksData"] }),
  });

  const deleteSelectedDeck = async () => {
    try {
      const data = await deleteDeckMutate(selectedDeckId);
      dispatch(
        setNotification({
          isShowing: true,
          isOk: true,
          msg: data?.msg,
        })
      );

      dispatch(setIsDeleteDeckModalOpen(false));
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

  const closeModal = () => {
    dispatch(setIsDeleteDeckModalOpen(false));
  };
  return {
    isDeleteDeckModalOpen,
    setIsModalOpen,
    selectedDeckTitle,
    closeModal,
    deleteSelectedDeck,
    isPending,
  };
};
