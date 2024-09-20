type deck = {
  id: string,
  title: string,
  reset_cards: int,
  review_cards: int,
  new_cards: int,
}

type response<'a> = {
  data: array<'a>,
  isOk: bool,
  msg: string,
}
