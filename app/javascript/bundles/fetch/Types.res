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

type card = {
  front: string,
  back: string,
  ease_factor: float,
  id: string,
  interval: int,
  mutable is_reset: bool,
  repetitions: int,
  review_at: int,
}
