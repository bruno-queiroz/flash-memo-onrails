export interface ServerResponse<T> {
  isOk: boolean;
  msg: string;
  data: T;
  errors?: { [key: string]: string[] };
}

export interface User {
  id: string;
  name: string;
  created_at: string;
  updated_at: string;
}

export interface Deck {
  id: string;
  title: string;
  created_at: string;
}

export interface Card {
  id: string;
  front: string;
  back: string;
  ease_factor: number;
  interval: number;
  repetitions: number;
  review_at: string | null;
  is_reset: boolean;
}

export type SearchCard = Pick<Card, "id" | "front" | "back" | "review_at">;
