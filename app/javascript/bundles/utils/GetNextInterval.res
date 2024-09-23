let get = (quality: int, card: Types.card) => {
  let {interval} = Algorithm.sm(
    ~quality,
    ~previousInterval=card.interval,
    ~previousEaseFactor=card.ease_factor,
    ~repetitions=ref(card.repetitions),
  )

  let formattedInterval = FormatInterval.format(interval)

  formattedInterval
}
