import React from "react";

import { TiArrowBack as BackIcon } from "react-icons/ti";

import { EditCardModal } from "../components/EditCardModal";
import { CRUDNotification } from "../components/CRUDNotification";
import { LoadSpinner } from "../components/LoadSpinner";
import { CardsCounterSkeleton } from "../components/CardsCounterSkeleton";

import {
  EASY_QUALITY_VALUE,
  GOOD_QUALITY_VALUE,
  HARD_QUALITY_VALUE,
} from "../algorithm/constants";
import { getNextInterval } from "../utils/getNextInterval";
import { useStudy } from "../hooks/useStudy";

export const Study = () => {
  const {
    cardsCounter,
    currentCard,
    isMutateCardLoading,
    isShowingAnswer,
    isStudyDeckLoading,
    onReset,
    openEditCardModal,
    reviewCard,
    setIsShowingAnswer,
    onReturnCard,
  } = useStudy();

  return (
    <section className="flex flex-col items-center gap-4 p-4 min-h-[85vh] max-w-[1300px] mx-auto">
      <EditCardModal />
      <CRUDNotification />
      <div className="flex items-center w-full md:w-[80%] justify-between text-lg font-semibold">
        {isStudyDeckLoading ? (
          <CardsCounterSkeleton />
        ) : (
          <div className="flex gap-1">
            <span className={`text-[#05668d] px-2`}>
              {cardsCounter.newCards}
            </span>
            <span className={`text-[#00a5cf] px-2 `}>
              {cardsCounter.resetCards}
            </span>
            <span className={`text-[#25a18e] px-2 `}>
              {cardsCounter.reviewCards}
            </span>
          </div>
        )}
        <div className="flex gap-4">
          <button
            className="py-[6px] px-4 bg-gray-200 dark:text-gray-300 dark:bg-neutral-900 rounded"
            onClick={onReturnCard}
          >
            <BackIcon />
          </button>
          <button
            className="py-[6px] px-4 bg-gray-200 dark:text-gray-300 dark:bg-neutral-900 rounded"
            onClick={openEditCardModal}
          >
            Edit
          </button>
        </div>
      </div>

      <div className="mx-auto w-full md:max-w-[80%] whitespace-pre-wrap">
        <div className="flex flex-col gap-4  shadow-md w-full p-4 rounded-tl-md rounded-tr-md text-center bg-gray-200 dark:bg-neutral-900 dark:text-gray-300 ">
          <h2 className="py-2 font-semibold text-lg">
            {isStudyDeckLoading ? (
              <div className="h-[12px] w-[200px] bg-gray-500 mx-auto" />
            ) : (
              <span>{currentCard?.front}</span>
            )}
          </h2>
          <div className="border-b-2 border-b-gray-400 dark:border-b-neutral-700 pb-2"></div>
        </div>
        <div
          className={`shadow-md w-full p-4  bg-gray-200 dark:bg-neutral-900 dark:text-gray-200  text-start transition-transform ease-in origin-top ${
            isShowingAnswer ? "scale-y-100 h-full" : "scale-y-0 h-[1px]"
          }`}
        >
          <p className={`${isShowingAnswer ? "block" : "hidden"}`}>
            {currentCard?.back}
          </p>
        </div>
      </div>

      <div className="flex gap-4 text-neutral-800 dark:text-white mt-auto font-semibold ">
        {isShowingAnswer ? (
          isMutateCardLoading ? (
            <span className="flex gap-1">
              sending card... <LoadSpinner />
            </span>
          ) : (
            <>
              <button
                className="py-2 px-4 rounded bg-red-500 text-white h-[max-content] mt-auto"
                onClick={onReset}
              >
                reset
              </button>
              <div className="flex flex-col text-neutral-800">
                <span className="mx-auto mb-1  dark:text-gray-300">
                  {getNextInterval(HARD_QUALITY_VALUE, currentCard)}
                </span>
                <button
                  className="py-2 px-4 rounded  bg-gray-300"
                  onClick={() => reviewCard(HARD_QUALITY_VALUE)}
                >
                  hard
                </button>
              </div>
              <div className="flex flex-col">
                <span className="mx-auto mb-1 text-[#00a5cf]">
                  {getNextInterval(GOOD_QUALITY_VALUE, currentCard)}
                </span>

                <button
                  className="py-2 px-4 rounded bg-[#00a5cf] text-white"
                  onClick={() => reviewCard(GOOD_QUALITY_VALUE)}
                >
                  good
                </button>
              </div>
              <div className="flex flex-col">
                <span className="text-[#25a18e] mx-auto mb-1">
                  {getNextInterval(EASY_QUALITY_VALUE, currentCard)}
                </span>

                <button
                  className="py-2 px-4 rounded bg-[#25a18e] text-white"
                  onClick={() => reviewCard(EASY_QUALITY_VALUE)}
                >
                  easy
                </button>
              </div>
            </>
          )
        ) : (
          <>
            {isMutateCardLoading ? (
              <span className="flex gap-4 items-center">
                sending card... <LoadSpinner />
              </span>
            ) : (
              <button
                className="py-2 px-4 text-white rounded bg-primary-yellow min-w-[315px]"
                onClick={() => setIsShowingAnswer(true)}
                disabled={isStudyDeckLoading}
              >
                {isStudyDeckLoading ? <LoadSpinner /> : "Show Answer"}
              </button>
            )}
          </>
        )}
      </div>
    </section>
  );
};
