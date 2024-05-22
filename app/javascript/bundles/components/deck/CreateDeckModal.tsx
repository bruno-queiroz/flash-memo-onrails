import React from "react";

import { LoadSpinner } from "../LoadSpinner";
import { ModalContainer } from "../ModalContainer";
import { Input } from "../Input";
import { useCreateDeckModal } from "../../hooks/useCreateDeckModal";

export const CreateDeckModal = () => {
  const {
    createDeck,
    deckNameRef,
    isCreateDeckModalOpen,
    isPending,
    setIsModalOpen,
  } = useCreateDeckModal();

  return (
    <ModalContainer
      {...{
        isModalOpen: isCreateDeckModalOpen,
        setIsModalOpen,
      }}
    >
      <form className="flex flex-col" onSubmit={createDeck}>
        <h3 className="text-2xl font-semibold mb-4">Create Deck</h3>
        <Input
          labelText="Deck Name"
          isSecondVariant={true}
          required
          ref={deckNameRef}
        />
        <button className="bg-primary-yellow py-2 px-4 rounded min-w-[80px] mx-auto mt-4 text-white">
          {isPending ? <LoadSpinner /> : "Create"}
        </button>{" "}
      </form>
    </ModalContainer>
  );
};
