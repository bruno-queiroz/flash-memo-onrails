import React from "react";

import { LoadSpinner } from "./LoadSpinner";
import { ModalContainer } from "./ModalContainer";
import { useDeckDeleteModal } from "../hooks/useDeleteDeckModal";

export const DeleteDeckModal = () => {
  const {
    closeModal,
    deleteSelectedDeck,
    isDeleteDeckModalOpen,
    isPending,
    selectedDeckTitle,
    setIsModalOpen,
  } = useDeckDeleteModal();

  return (
    <ModalContainer
      {...{
        isModalOpen: isDeleteDeckModalOpen,
        setIsModalOpen,
      }}
    >
      <h3 className="text-2xl font-semibold mb-4">Delete Deck</h3>
      <p>
        Wanna{" "}
        <span className="text-primary-yellow">
          delete `{selectedDeckTitle}`
        </span>{" "}
        deck? You'll lose all cards created in this deck
      </p>
      <div className="flex gap-4 mt-4 justify-end">
        <button
          className="py-2 px-4 rounded bg-gray-300 dark:bg-neutral-700"
          onClick={closeModal}
        >
          Cancel
        </button>
        <button
          className="py-2 px-4 min-w-[78px] rounded bg-red-500 text-white"
          onClick={deleteSelectedDeck}
          disabled={isPending}
        >
          {isPending ? <LoadSpinner /> : "Delete"}
        </button>
      </div>
    </ModalContainer>
  );
};
