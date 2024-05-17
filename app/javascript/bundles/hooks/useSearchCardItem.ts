import { useMutation, useQueryClient } from "@tanstack/react-query";
import { deleteCard } from "../fetch/deleteCard";

import { useAppDispatch } from "../hooks/useAppDispatch";
import { setNotification } from "../global-state/reducers/notificationSlice";
import { setIsEditCardModalOpen } from "../global-state/reducers/cardSlice";
import { setSelectedCard } from "../global-state/reducers/selectedCardSlice";

import { formatText } from "../utils/formatText";
import { SearchCard } from "../fetch/types";

type UseSearchCardItem = Pick<SearchCard, "front" | "back" | "id"> & {
  reSearchCards: () => void;
};

export const useSearchCardItem = ({
  front,
  back,
  id,
  reSearchCards,
}: UseSearchCardItem) => {
  const queryClient = useQueryClient();
  const { mutateAsync: deleteCardMutate, isPending } = useMutation({
    mutationFn: (cardId: string) => deleteCard(cardId),
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ["searchCards"] });
      reSearchCards();
    },
  });

  const dispatch = useAppDispatch();

  const openEditModal = () => {
    dispatch(setSelectedCard({ front, back, cardId: id }));
    dispatch(setIsEditCardModalOpen(true));
  };

  const deleteSelectedCard = async () => {
    const response = await deleteCardMutate(id);
    dispatch(
      setNotification({
        isShowing: true,
        isOk: response?.isOk,
        msg: response?.msg,
      })
    );
  };

  const frontTextFormatted = formatText(front);
  const backTextFormatted = formatText(back);

  return {
    frontTextFormatted,
    backTextFormatted,
    openEditModal,
    deleteSelectedCard,
    isPending,
  };
};
