import React from "react";

import { SearchCardItem } from "../components/card/SearchCardItem";
import { CardNotFound } from "../components/card/CardNotFound";
import { EditCardModal } from "../components/card/EditCardModal";
import { LoadingDots } from "../components/LoadingDots";

import { useSearchCards } from "../hooks/useSearchCards";

export const SearchCards = () => {
  const {
    data,
    deckSelectRef,
    decks,
    error,
    isError,
    isPending,
    onSearch,
    searchInputRef,
    reSearchCards,
  } = useSearchCards();

  return (
    <>
      <EditCardModal reSearchCards={reSearchCards} />

      <section className="flex flex-col items-center p-4 dark:text-gray-300 text-black">
        <h1 className="font-bold text-center text-4xl text-neutral-800 dark:text-white">
          Search cards
        </h1>
        <div className="max-w-[900px] w-full">
          <form
            className="flex flex-col gap-4 items-center mx-auto mt-8"
            onSubmit={onSearch}
          >
            <label className="flex items-center gap-3">
              <span>Select a deck</span>
              <select
                className="bg-gray-200 dark:bg-neutral-900 p-1"
                ref={deckSelectRef}
              >
                {decks?.data?.map((deck) => (
                  <option value={deck?.id} key={deck?.id}>
                    {deck?.title}
                  </option>
                ))}
              </select>
            </label>
            <div className="flex gap-2 w-full">
              <input
                type="text"
                aria-label="search card"
                autoFocus
                className="bg-gray-200 dark:bg-neutral-900 w-full p-2"
                ref={searchInputRef}
                required
              />
              <button className="bg-dark-blue dark:bg-aqua-blue dark:text-neutral-900 font-semibold text-white p-2 rounded-tr">
                Search
              </button>
            </div>
          </form>

          <div className="flex flex-col gap-4 mt-8">
            {isPending ? (
              <LoadingDots />
            ) : isError ? (
              <CardNotFound errorMessage={error?.message} />
            ) : (
              data?.data?.map((card) => (
                <SearchCardItem
                  {...card}
                  reSearchCards={reSearchCards}
                  key={card?.id}
                />
              ))
            )}
          </div>
        </div>
      </section>
    </>
  );
};
