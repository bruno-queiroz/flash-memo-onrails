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

export interface SearchCard {
  id: string;
  front: string;
  back: string;
  review_at: string | null;
}
