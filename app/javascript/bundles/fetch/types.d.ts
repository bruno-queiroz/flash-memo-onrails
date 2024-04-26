export interface ServerResponse<T> {
  isOk: boolean;
  msg: string;
  data: T;
  errors?: { [key: string]: string[] };
}
