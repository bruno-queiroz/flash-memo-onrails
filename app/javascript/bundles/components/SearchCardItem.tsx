import React, { Fragment } from "react";

import { SearchCard } from "../fetch/types";

import { RiDeleteBin7Line as DeleteIcon } from "react-icons/ri";

import { LoadSpinner } from "./LoadSpinner";
import { CardReviewDate } from "./CardReviewDate";
import { useSearchCardItem } from "../hooks/useSearchCardItem";

export const SearchCardItem = ({ front, back, review_at, id }: SearchCard) => {
  const {
    backTextFormatted,
    deleteSelectedCard,
    frontTextFormatted,
    isPending,
    openEditModal,
  } = useSearchCardItem({ front, back, id });

  return (
    <article className="bg-gray-200 dark:bg-neutral-900 rounded px-4 pb-4">
      <div className="py-4">
        {frontTextFormatted.map((front, index) => (
          <Fragment key={index}>
            {front}
            <br />
          </Fragment>
        ))}
      </div>
      <div className="border-b-2 border-b-gray-400 dark:border-b-neutral-700" />
      <div className="py-4">
        {backTextFormatted.map((back, index) => (
          <Fragment key={index}>
            {back}
            <br />
          </Fragment>
        ))}
      </div>
      <div className="flex justify-between items-center">
        <div className="flex gap-4">
          <button
            className="bg-primary-yellow py-1 px-3 rounded font-semibold text-neutral-900"
            onClick={openEditModal}
          >
            Edit
          </button>
          <button
            className="bg-gray-300 dark:bg-neutral-800 rounded py-1 px-3"
            onClick={deleteSelectedCard}
          >
            {isPending ? <LoadSpinner /> : <DeleteIcon />}
          </button>
        </div>
        <div>
          <span>Review in: </span>
          <CardReviewDate review_at={review_at} />
        </div>
      </div>
    </article>
  );
};
