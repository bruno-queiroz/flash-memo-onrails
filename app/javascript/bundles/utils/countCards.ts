import { Card } from "../fetch/types";

export const countCards = (cards: Card[]) => {
  const counter = {
    newCards: 0,
    resetCards: 0,
    reviewCards: 0,
  };

  cards.forEach((card) => {
    if (card.is_reset) {
      counter.resetCards = counter.resetCards + 1;
    } else if (card.repetitions === 0) {
      counter.newCards = counter.newCards + 1;
    } else {
      counter.reviewCards = counter.reviewCards + 1;
    }
  });

  return counter;
};
