import React from "react";

import { Link } from "react-router-dom";
import { BiDotsVerticalRounded as DotsIcon } from "react-icons/bi";
import { Deck } from "../../fetch/types";
import { useDeckStatus } from "../../hooks/useDeckStatus";

export const DeckStatus = ({
  title,
  id,
  new_cards,
  reset_cards,
  review_cards,
}: Deck) => {
  const {
    isOptionsActive,
    openDeckOptions,
    openDeleteDeckModal,
    openEditNameDeckModal,
  } = useDeckStatus(title, id);

  return (
    <article className="flex items-center rounded-lg text-neutral-800 dark:text-gray-300 dark:bg-neutral-900 shadow-md bg-gray-200">
      <Link
        to={`/study/${title}`}
        // onClick={checkDeckCardsAvailability}
        className="flex-1 p-4 dark:hover:bg-neutral-950 font-semibold hover:bg-gray-300 transition-colors rounded-tl-lg rounded-bl-lg"
      >
        {title}
      </Link>

      <div className="flex gap-6 p-4">
        <div className="flex gap-1">
          <span className="text-[#05668d] font-semibold">{new_cards}</span>
          <span className="text-[#00a5cf] font-semibold">{reset_cards}</span>
          <span className="text-[#25a18e] font-semibold">{review_cards}</span>
        </div>

        <div className="flex items-center relative">
          <button
            className="text-2xl text-dark-blue dark:text-white relative"
            onClick={openDeckOptions}
          >
            <DotsIcon />
            <div
              className="absolute w-full h-full bg-transparent top-0"
              id="deck-option"
            />
          </button>
          <div
            className={`absolute z-10 right-0 font-semibold flex-col top-[100%] py-2 w-[120px] dark:bg-neutral-950 dark:text-gray-300 bg-[#F4F5F6] shadow-2xl text-neutral-800 rounded text-sm ${
              isOptionsActive ? "flex" : "hidden"
            }`}
          >
            <button
              className="p-2 hover:bg-gray-300 dark:hover:bg-neutral-900 transition-colors"
              onClick={openDeleteDeckModal}
            >
              Delete Deck
            </button>
            <button
              className="p-2 hover:bg-gray-300 dark:hover:bg-neutral-900 transition-colors"
              onClick={openEditNameDeckModal}
            >
              Rename Deck
            </button>
          </div>
        </div>
      </div>
    </article>
  );
};
