import { sm } from "../algorithm/sm";
import { Card } from "../fetch/types";

export const evaluateCard = (card: Card, quality: number) => {
  const { ease_factor, interval, repetitions } = sm(
    quality,
    card.interval,
    card.ease_factor,
    card.repetitions
  );

  const reviewedCard = {
    ...card,
    ease_factor,
    interval,
    repetitions,
  };

  return reviewedCard;
};
