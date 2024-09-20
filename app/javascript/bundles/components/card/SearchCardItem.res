@react.component
let make = (~front, ~back, ~review_at, ~id, ~reSearchCards) => {
  let {
    backTextFormatted,
    deleteSelectedCard,
    frontTextFormatted,
    isPending,
    openEditModal,
  } = SearchCardItemHook.useSearchCardItem(front, back, id, reSearchCards)

  <article className="bg-gray-200 dark:bg-neutral-900 rounded px-4 pb-4">
    <div className="py-4">
      {frontTextFormatted
      ->Array.mapWithIndex((front, index) =>
        switch front {
        | Some(front) =>
          <React.Fragment key={Int.toString(index)}>
            {front->React.string}
            <br />
          </React.Fragment>
        | None => React.null
        }
      )
      ->React.array}
    </div>
    <div className="border-b-2 border-b-gray-400 dark:border-b-neutral-700" />
    <div className="py-4">
      {backTextFormatted
      ->Array.mapWithIndex((back, index) =>
        switch back {
        | Some(back) =>
          <React.Fragment key={Int.toString(index)}>
            {back->React.string}
            <br />
          </React.Fragment>
        | None => React.null
        }
      )
      ->React.array}
    </div>
    <div className="flex justify-between items-center">
      <div className="flex gap-4">
        <button
          className="bg-primary-yellow py-1 px-3 rounded font-semibold text-neutral-900"
          onClick={_ => openEditModal()}>
          {"Edit"->React.string}
        </button>
        <button
          className="bg-gray-300 dark:bg-neutral-800 rounded py-1 px-3"
          onClick={_ => {
            let _ = deleteSelectedCard()
          }}>
          {isPending ? <LoadSpinner /> : <Icons.DeleteIcon />}
        </button>
      </div>
      <div>
        <span> {"Review in:"->React.string} </span>
        <CardReviewDate review_at={review_at} />
      </div>
    </div>
  </article>
}
