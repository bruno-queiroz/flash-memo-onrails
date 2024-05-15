import React from "react";

import { DeckStatus } from "../components/DeckStatus";
import { CreateDeckModal } from "../components/CreateDeckModal";
import { DeleteDeckModal } from "../components/DeleteDeckModal";
import { EditDeckNameModal } from "../components/EditDeckNameModal";
import { DeckSkeleton } from "../components/DeckSkeleton";
import { DeckMessage } from "../components/DeckMessage";
import { CRUDNotification } from "../components/CRUDNotification";

import { useDecks } from "../hooks/useDecks";

export const Decks = () => {
  const { decks, isError, isPending, openCreateDeckModal } = useDecks();

  return (
    <section className="flex flex-col gap-6 items-center p-4 dark:text-gray-300 min-h-screen">
      <CRUDNotification />
      <DeleteDeckModal />
      <CreateDeckModal />
      <EditDeckNameModal />
      <h1 className="font-bold text-center text-4xl text-neutral-800 dark:text-white">
        Decks
      </h1>

      <div className="flex flex-col gap-2 max-w-[1000px] w-full">
        {isPending ? (
          <DeckSkeleton />
        ) : (
          <>
            {decks?.data?.length === 0 ? (
              <DeckMessage message="Looks like you don't have a deck yet. Why don't you create one?" />
            ) : isError ? (
              <DeckMessage message="Something went wrong" />
            ) : (
              decks?.data?.map((deck) => <DeckStatus {...deck} key={deck.id} />)
            )}
          </>
        )}
      </div>

      <button
        type="button"
        disabled={isPending}
        className="bg-primary-yellow py-2 px-4 rounded w-[max-content] mx-auto mt-4 text-white font-semibold"
        onClick={openCreateDeckModal}
      >
        Create Deck
      </button>
    </section>
  );
};
