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
    if (repetitions === 0) {
      interval = 1;
    } else if (repetitions === 1) {
      interval = 6;
    } else {
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
