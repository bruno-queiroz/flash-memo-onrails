import React, { ReactNode, useEffect, useState } from "react";
import { useModalContainer } from "../hooks/useModalContainer";

export interface ModalContainerProps {
  isModalOpen: boolean;
  setIsModalOpen: (boolean: boolean) => void;
  children: ReactNode;
}

export const ModalContainer = ({
  children,
  isModalOpen,
  setIsModalOpen,
}: ModalContainerProps) => {
  const { isDialogOpen, dialogAnimationEnd, closeModal } = useModalContainer({
    isModalOpen,
    setIsModalOpen,
  });

  return (
    <>
      <div
        className={`${
          isModalOpen ? "translate-y-0" : "translate-y-[-100%]"
        } fixed bottom-0 left-0 right-0 w-full h-full bg-[rgba(0,0,0,0.2)] z-10`}
        onClick={closeModal}
      />

      <dialog
        open={isDialogOpen}
        onAnimationEnd={dialogAnimationEnd}
        className={`fixed p-4 max-w-[500px] w-[95%] dark:bg-neutral-800 dark:text-white rounded top-0 z-10 ${
          isModalOpen ? "show-modal-animation" : "close-modal-animation"
        }`}
      >
        {children}
      </dialog>
    </>
  );
};
