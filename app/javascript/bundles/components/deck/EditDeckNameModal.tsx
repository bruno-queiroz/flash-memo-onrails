import React from "react";

import { ModalContainer } from "../ModalContainer";
import { Input } from "../Input";
import { useEditDeckNameModal } from "../../hooks/useEditDeckNameModal";

export const EditDeckNameModal = () => {
  const {
    deckNameInputRef,
    isEditDeckNameModalOpen,
    onEditDeckName,
    setIsModalOpen,
  } = useEditDeckNameModal();

  return (
    <ModalContainer
      {...{
        isModalOpen: isEditDeckNameModalOpen,
        setIsModalOpen,
      }}
    >
      <form className="flex flex-col gap-4" onSubmit={onEditDeckName}>
        <h3 className="text-2xl font-semibold">Edit Deck Name</h3>

        <Input
          labelText="Deck Name"
          isSecondVariant
          ref={deckNameInputRef}
          required
        />
        <div className="flex justify-end">
          <button className="py-2 px-4 w-[78px] font-semibold rounded dark:bg-neutral-700 bg-gray-200  dark:text-white">
            Edit
          </button>
        </div>
      </form>
    </ModalContainer>
  );
};
