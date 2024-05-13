import { useSelector } from "react-redux";
import type { RootState } from "../global-state/store";

export const useAppSelector = useSelector.withTypes<RootState>();
