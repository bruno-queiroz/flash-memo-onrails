let card = (~card: Types.card, ~quality: int) => {
  let {interval, ease_factor, repetitions} = Algorithm.sm(
    ~quality,
    ~previousInterval=card.interval,
    ~previousEaseFactor=card.ease_factor,
    ~repetitions=ref(card.repetitions),
  )

  let reviewedCard = {
    ...card,
    interval,
    ease_factor,
    repetitions,
  }

  reviewedCard
}
