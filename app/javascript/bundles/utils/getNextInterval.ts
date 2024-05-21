import { sm } from "../algorithm/sm";
import { Card } from "../fetch/types";
import { formatInterval } from "./formatInterval";

export const getNextInterval = (quality: number, card: Card) => {
  const { interval } = sm(
    quality,
    card.interval,
    card.ease_factor,
    card.repetitions
  );

  const formattedInterval = formatInterval(interval);

  return formattedInterval;
};
