import React from "react";

import { Form } from "../components/Form";
import { LoadSpinner } from "../components/LoadSpinner";
import { useAddCard } from "../hooks/useAddCard";

export const AddCard = () => {
  const {
    cardBackInputRef,
    cardFrontInputRef,
    cardSelectRef,
    decks,
    isPending,
    submitCard,
  } = useAddCard();

  return (
    <section className="flex gap-4 flex-col p-4 items-center dark:text-gray-300 text-black">
      <h1 className="font-bold text-center text-4xl text-neutral-800 dark:text-white">
        Add
      </h1>

      <Form onSubmit={submitCard}>
        <label className="flex flex-col gap-2">
          <span>Deck</span>
          <select
            required
            autoFocus
            className="dark:bg-neutral-800 bg-white p-1"
            ref={cardSelectRef}
          >
            {decks?.data?.map((deck) => (
              <option value={deck?.id} key={deck?.id}>
                {deck?.title}
              </option>
            ))}
          </select>
        </label>
        <label className="flex flex-col gap-2">
          <span>Card Front</span>
          <textarea
            required
            ref={cardFrontInputRef}
            className="dark:bg-neutral-800 bg-white p-2"
          ></textarea>
        </label>
        <label className="flex flex-col gap-2">
          <span>Card Back</span>
          <textarea
            required
            ref={cardBackInputRef}
            className="dark:bg-neutral-800 bg-white p-2"
          ></textarea>
        </label>
        <button className="bg-primary-yellow py-2 px-4 rounded w-[80px] mx-auto mt-4 text-white font-semibold">
          {isPending ? <LoadSpinner /> : "Create"}
        </button>
      </Form>
    </section>
  );
};
