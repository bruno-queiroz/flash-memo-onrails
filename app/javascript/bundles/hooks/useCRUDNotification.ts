import { useEffect } from "react";

import { useAppSelector } from "../hooks/useAppSelector";
import { useAppDispatch } from "../hooks/useAppDispatch";

import { setNotification } from "../global-state/reducers/notificationSlice";

export const useCRUDNotification = () => {
  const { msg, isOk, isShowing } = useAppSelector(
    (state) => state.notification.content
  );

  const dispatch = useAppDispatch();

  useEffect(() => {
    if (isShowing) {
      setTimeout(() => {
        dispatch(
          setNotification({
            isOk,
            msg,
            isShowing: false,
          })
        );
      }, 2000);
    }
  }, [isShowing]);

  return {
    isShowing,
    isOk,
    msg,
  };
};
