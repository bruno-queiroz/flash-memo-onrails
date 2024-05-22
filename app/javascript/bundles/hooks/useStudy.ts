import { useEffect, useState } from "react";

import { useMutation } from "@tanstack/react-query";
import { useNavigate, useParams } from "react-router-dom";

import { getStudyDeck } from "../fetch/getStudyDeck";
import { patchCardInterval } from "../fetch/patchCardInterval";
import { Card } from "../fetch/types";

import { useAppDispatch } from "../hooks/useAppDispatch";
import { setSelectedCard } from "../global-state/reducers/selectedCardSlice";
import { setIsEditCardModalOpen } from "../global-state/reducers/cardSlice";

import { countCards } from "../utils/countCards";
import { evaluateCard } from "../utils/evaluateCard";
import { RESET_QUALITY_VALUE } from "../algorithm/constants";
import { setNotification } from "../global-state/reducers/notificationSlice";

let cards = [];
const reviewedCards = [];

export const useStudy = () => {
  const { deckTitle } = useParams();
  const navigate = useNavigate();

  const [isStudyDeckLoading, setIsStudyDeckLoading] = useState(false);

  const { mutateAsync: cardMutate, isPending: isMutateCardLoading } =
    useMutation({
      mutationFn: (data: Card) => patchCardInterval(data),
    });

  useEffect(() => {
    const getData = async () => {
      try {
        setIsStudyDeckLoading(true);
        const data = await getStudyDeck(deckTitle);
        setIsStudyDeckLoading(false);

        if (!data?.data || data?.data.length === 0) {
          navigate("/decks");

          dispatch(
            setNotification({
              isShowing: true,
              isOk: true,
              msg: "No cards to study.",
            })
          );
          return;
        }

        cards = data.data;

        setCurrentCard(cards[cards.length - 1]);
        setCardsCounter(countCards(cards));
      } catch (err) {
        setIsStudyDeckLoading(false);

        navigate("/decks");

        dispatch(
          setNotification({
            isShowing: true,
            isOk: false,
            msg: "Something went wrong.",
          })
        );
      }
    };
    getData();
  }, []);

  const dispatch = useAppDispatch();

  const openEditCardModal = () => {
    dispatch(
      setSelectedCard({
        front: currentCard?.front,
        back: currentCard?.back,
        cardId: currentCard?.id,
      })
    );
    dispatch(setIsEditCardModalOpen(true));
  };

  const [cardsCounter, setCardsCounter] = useState({
    newCards: 0,
    resetCards: 0,
    reviewCards: 0,
  });

  const [isShowingAnswer, setIsShowingAnswer] = useState(false);
  const [currentCard, setCurrentCard] = useState<Card>({
    front: "",
    back: "",
    ease_factor: 0,
    id: "",
    interval: 0,
    is_reset: false,
    repetitions: 0,
    review_at: null,
  });

  const reviewCard = async (quality: number) => {
    if (cards.length === 0) return;

    const card = cards.pop();
    card.is_reset = false;
    reviewedCards.push(card);

    const reviewedCard = evaluateCard(card, quality);
    try {
      await cardMutate(reviewedCard);

      if (cards.length === 0) {
        navigate("/decks");

        dispatch(
          setNotification({
            isShowing: true,
            isOk: true,
            msg: "Studies finished.",
          })
        );
        return;
      }

      setCardsCounter(countCards(cards));
      setCurrentCard(cards[cards.length - 1]);
    } catch (err) {
      cards.push(card);
      reviewedCards.pop();

      dispatch(
        setNotification({
          isShowing: true,
          isOk: false,
          msg: "Failed to review card.",
        })
      );
    }
  };

  const onReset = async () => {
    const card = cards.pop();
    card.is_reset = true;

    reviewedCards.push(card);
    cards.unshift(card);

    const reviewedCard = evaluateCard(card, RESET_QUALITY_VALUE);

    try {
      await cardMutate(reviewedCard);

      setCardsCounter(countCards(cards));
      setCurrentCard(cards[cards.length - 1]);
    } catch (err) {
      card.is_reset = false;
      cards.push(card);
      cards.shift();

      dispatch(
        setNotification({
          isShowing: true,
          isOk: false,
          msg: "Failed to review card.",
        })
      );
    }
  };

  const onReturnCard = () => {
    if (reviewedCards.length === 0) return;

    const reviewedCard = reviewedCards.pop();

    if (reviewedCard.is_reset) {
      const card = cards.shift();
      card.is_reset = false;
      cards.push(card);
    } else {
      cards.push(reviewedCard);
    }

    setCurrentCard(reviewedCard);
    setCardsCounter(countCards(cards));
  };

  return {
    isStudyDeckLoading,
    cardsCounter,
    openEditCardModal,
    currentCard,
    isShowingAnswer,
    isMutateCardLoading,
    onReset,
    reviewCard,
    setIsShowingAnswer,
    onReturnCard,
  };
};
