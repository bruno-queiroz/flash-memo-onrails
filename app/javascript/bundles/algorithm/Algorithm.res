type sm = {
  interval: int,
  ease_factor: float,
  repetitions: int,
}

let sm = (
  ~quality: int,
  ~previousInterval: int,
  ~previousEaseFactor: float,
  ~repetitions: ref<int>,
) => {
  let interval = ref(0)
  let ease_factor = ref(
    previousEaseFactor +.
    (0.1 -.
    (5.0 -. Belt.Int.toFloat(quality)) *. (0.08 +. (5.0 -. Belt.Int.toFloat(quality)) *. 0.02)),
  )

  if quality >= 3 {
    switch repetitions.contents {
    | 0 =>
      if quality === Constants.hard_quality_value {
        interval := 1
      } else if quality === Constants.good_quality_value {
        interval := 2
      } else {
        interval := 4
      }
    | 1 =>
      if quality === Constants.hard_quality_value {
        interval := 3
      } else if quality === Constants.good_quality_value {
        interval := 5
      } else {
        interval := 7
      }
    | 2 =>
      if quality === Constants.hard_quality_value {
        interval := 6
      } else if quality === Constants.good_quality_value {
        interval := 8
      } else {
        interval := 10
      }
    | _ => interval := previousInterval * Belt.Float.toInt(ease_factor.contents)
    }

    repetitions := repetitions.contents + 1
  } else {
    repetitions := 0
    ease_factor := previousEaseFactor
    interval := 1
  }

  if ease_factor.contents < 1.3 {
    ease_factor := 1.3
  }

  {
    interval: interval.contents,
    ease_factor: ease_factor.contents,
    repetitions: repetitions.contents,
  }
}
