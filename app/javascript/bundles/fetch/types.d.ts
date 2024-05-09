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
