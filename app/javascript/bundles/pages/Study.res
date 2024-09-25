@react.component
let make = () => {
  let {
    isStudyDeckLoading,
    isMutateCardLoading,
    cardsCounter,
    onReturnCard,
    currentCard,
    reviewCard,
    isShowingAnswer,
    setIsShowingAnswer,
    onReset,
    openEditCardModal,
  } = StudyHook.useStudy()

  <section className="flex flex-col items-center gap-4 p-4 min-h-[85vh] max-w-[1300px] mx-auto">
    <div className="flex items-center w-full md:w-[80%] justify-between text-lg font-semibold">
      {if isStudyDeckLoading {
        React.string("cards skeleton")
      } else {
        <div className="flex gap-1">
          <span className={`text-[#05668d] px-2`}>
            {cardsCounter.newCards->Belt.Int.toString->React.string}
          </span>
          <span className={`text-[#00a5cf] px-2 `}>
            {cardsCounter.resetCards->Belt.Int.toString->React.string}
          </span>
          <span className={`text-[#25a18e] px-2 `}>
            {cardsCounter.reviewCards->Belt.Int.toString->React.string}
          </span>
        </div>
      }}
      <div className="flex gap-4">
        <button
          className="py-[6px] px-4 bg-gray-200 dark:text-gray-300 dark:bg-neutral-900 rounded"
          onClick={_ => onReturnCard()}>
          {React.string("<-")}
        </button>
        <button
          className="py-[6px] px-4 bg-gray-200 dark:text-gray-300 dark:bg-neutral-900 rounded"
          onClick={_ => openEditCardModal()}>
          {React.string("Edit")}
        </button>
      </div>
    </div>
    <div className="mx-auto w-full md:max-w-[80%] whitespace-pre-wrap">
      <div
        className="flex flex-col gap-4  shadow-md w-full p-4 rounded-tl-md rounded-tr-md text-center bg-gray-200 dark:bg-neutral-900 dark:text-gray-300 ">
        <h2 className="py-2 font-semibold text-lg">
          {if isStudyDeckLoading {
            <div className="h-[12px] w-[200px] bg-gray-500 mx-auto" />
          } else {
            <span> {React.string(currentCard.front)} </span>
          }}
        </h2>
        <div className="border-b-2 border-b-gray-400 dark:border-b-neutral-700 pb-2" />
      </div>
      <div
        className={`shadow-md w-full p-4  bg-gray-200 dark:bg-neutral-900 dark:text-gray-200  text-start transition-transform ease-in origin-top ${isShowingAnswer
            ? "scale-y-100 h-full"
            : "scale-y-0 h-[1px]"}`}>
        <p className={`${isShowingAnswer ? "block" : "hidden"}`}>
          {React.string(currentCard.back)}
        </p>
      </div>
    </div>
    <div className="flex gap-4 text-neutral-800 dark:text-white mt-auto font-semibold ">
      {switch [isShowingAnswer, isMutateCardLoading] {
      | [true, false] =>
        <>
          <button
            className="py-2 px-4 rounded bg-red-500 text-white h-[max-content] mt-auto"
            onClick={_ => {
              let _ = onReset()
            }}>
            {React.string("reset")}
          </button>
          <div className="flex flex-col text-neutral-800">
            <span className="mx-auto mb-1  dark:text-gray-300">
              {React.string(GetNextInterval.get(Constants.hard_quality_value, currentCard))}
            </span>
            <button
              className="py-2 px-4 rounded  bg-gray-300"
              onClick={_ => {
                let _ = reviewCard(~quality=Constants.hard_quality_value)
              }}>
              {React.string("hard")}
            </button>
          </div>
          <div className="flex flex-col">
            <span className="mx-auto mb-1 text-[#00a5cf]">
              {React.string(GetNextInterval.get(Constants.good_quality_value, currentCard))}
            </span>
            <button
              className="py-2 px-4 rounded bg-[#00a5cf] text-white"
              onClick={_ => {
                let _ = reviewCard(~quality=Constants.good_quality_value)
              }}>
              {React.string("good")}
            </button>
          </div>
          <div className="flex flex-col">
            <span className="text-[#25a18e] mx-auto mb-1">
              {React.string(GetNextInterval.get(Constants.easy_quality_value, currentCard))}
            </span>
            <button
              className="py-2 px-4 rounded bg-[#25a18e] text-white"
              onClick={_ => {
                let _ = reviewCard(~quality=Constants.easy_quality_value)
              }}>
              {React.string("easy")}
            </button>
          </div>
        </>
      | [true, true] => <span className="flex gap-1"> {React.string("sending card...")} </span>
      | [false, false] =>
        <button
          className="py-2 px-4 text-white rounded bg-[#ff9f1c] min-w-[315px]"
          onClick={_ => setIsShowingAnswer(_ => true)}
          disabled={isStudyDeckLoading}>
          {isStudyDeckLoading ? React.string("loading...") : React.string("Show Answer")}
        </button>
      | [false, true] =>
        <span className="flex gap-4 items-center"> {React.string("sending card...")} </span>
      | _ => <span> {React.string("something went wrong")} </span>
      }}
    </div>
  </section>
}
