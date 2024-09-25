type t = {
  mutable newCards: int,
  mutable resetCards: int,
  mutable reviewCards: int,
}

let cards = (~cards: array<Types.card>) => {
  let counter = {
    newCards: 0,
    resetCards: 0,
    reviewCards: 0,
  }

  cards->Array.forEach(card => {
    if card.is_reset {
      counter.resetCards = counter.resetCards + 1
    } else if card.repetitions === 0 {
      counter.newCards = counter.newCards + 1
    } else {
      counter.reviewCards = counter.reviewCards + 1
    }
  })

  counter
}
