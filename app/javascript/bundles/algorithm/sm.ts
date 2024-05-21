import { GOOD_QUALITY_VALUE, HARD_QUALITY_VALUE } from "./constants";

export const sm = (
  quality: number,
  previousInterval: number,
  previousEaseFactor: number,
  repetitions: number
) => {
  let interval = 0;
  let ease_factor = 0;

  ease_factor =
    previousEaseFactor + (0.1 - (5 - quality) * (0.08 + (5 - quality) * 0.02));

  if (quality >= 3) {
    switch (repetitions) {
      case 0:
        if (quality === HARD_QUALITY_VALUE) {
          interval = 1;
        } else if (quality === GOOD_QUALITY_VALUE) {
          interval = 2;
        } else {
          interval = 4;
        }
        break;
      case 1:
        if (quality === HARD_QUALITY_VALUE) {
          interval = 3;
        } else if (quality === GOOD_QUALITY_VALUE) {
          interval = 5;
        } else {
          interval = 7;
        }
        break;
      case 2:
        if (quality === HARD_QUALITY_VALUE) {
          interval = 6;
        } else if (quality === GOOD_QUALITY_VALUE) {
          interval = 8;
        } else {
          interval = 10;
        }
        break;
      default:
        interval = Math.round(previousInterval * ease_factor);
    }

    repetitions++;
  } else {
    repetitions = 0;
    ease_factor = previousEaseFactor;
    interval = 1;
  }

  if (ease_factor < 1.3) {
    ease_factor = 1.3;
  }

  return { interval, ease_factor, repetitions };
};
