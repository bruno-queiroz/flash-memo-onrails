import React from "react";
import { useCRUDNotification } from "../hooks/useCRUDNotification";

export const CRUDNotification = () => {
  const { isOk, isShowing, msg } = useCRUDNotification();

  return (
    <div
      className={`fixed top-20 z-20 left-0 min-w-[150px] p-6 bg-gray-200 shadow-md font-semibold transition-transform dark:bg-neutral-900 rounded-tr rounded-br ${
        isOk ? "text-green-600" : "text-red-500"
      } ${isShowing ? "translate-x-0" : "translate-x-[-100%]"}`}
    >
      {msg}
    </div>
  );
};
