import React, { useEffect, useRef } from "react";

import { Form } from "./Form";
import { LoadSpinner } from "./LoadSpinner";
import { ModalContainer } from "./ModalContainer";
import { useEditCardModal } from "../hooks/useEditCardModal";

interface EditCardModalProps {
  reSearchCards?: () => void;
}

export const EditCardModal = ({ reSearchCards }: EditCardModalProps) => {
  const {
    cardBackInputRef,
    cardFrontInputRef,
    editCard,
    isEditCardLoading,
    isEditCardModalOpen,
    setIsModalOpen,
  } = useEditCardModal(reSearchCards);

  return (
    <>
      <ModalContainer
        {...{
          isModalOpen: isEditCardModalOpen,
          setIsModalOpen,
        }}
      >
        <Form className="flex flex-col items-center gap-4" onSubmit={editCard}>
          <h2 className="font-semibold text-center text-2xl text-neutral-800 dark:text-white">
            Edit Card
          </h2>
          <label className="flex flex-col gap-2 w-full">
            <span>Card Front</span>
            <textarea
              required
              ref={cardFrontInputRef}
              className="dark:bg-neutral-900 bg-gray-200 p-2"
            />
          </label>
          <label className="flex flex-col gap-2 w-full">
            <span>Card Back</span>
            <textarea
              required
              ref={cardBackInputRef}
              className="dark:bg-neutral-900 bg-gray-200 p-2"
            />
          </label>
          <button className="bg-primary-yellow py-2 px-4 rounded w-[80px] mx-auto mt-4 text-white">
            {isEditCardLoading ? <LoadSpinner /> : "Edit"}
          </button>
        </Form>
      </ModalContainer>
    </>
  );
};
