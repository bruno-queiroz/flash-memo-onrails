import { useDispatch } from "react-redux";
import type { AppDispatch } from "../global-state/store";

export const useAppDispatch = useDispatch.withTypes<AppDispatch>();
