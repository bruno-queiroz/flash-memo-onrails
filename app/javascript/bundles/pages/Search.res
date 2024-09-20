@react.component
let make = () => {
  let {
    data,
    deckSelectRef,
    decks,
    error,
    isError,
    isPending,
    onSearch,
    searchInputRef,
    reSearchCards,
  } = SearchCardsHook.useSearchCards()

  let deckSelectRef = (Obj.magic(deckSelectRef): JsxDOM.domRef)
  let searchInputRef = (Obj.magic(searchInputRef): JsxDOM.domRef)
  <>
    <EditCardModal reSearchCards={reSearchCards} />
    <section className="flex flex-col items-center p-4 dark:text-gray-300 text-black">
      <h1 className="font-bold text-center text-4xl text-neutral-800 dark:text-white">
        {"Search Cards"->React.string}
      </h1>
      <div className="max-w-[900px] w-full">
        <form
          className="flex flex-col gap-4 items-center mx-auto mt-8"
          onSubmit={event => {
            let _ = onSearch(event)
          }}>
          <label className="flex items-center gap-3">
            <span> {"Select a Deck"->React.string} </span>
            <select className="bg-gray-200 dark:bg-neutral-900 p-1" ref={deckSelectRef}>
              {switch decks {
              | None => <option value=""> {"No decks available"->React.string} </option>
              | Some(decks) =>
                decks.data
                ->Array.map(deck => {
                  <option key={deck.id} value={deck.id}> {deck.title->React.string} </option>
                })
                ->React.array
              }}
            </select>
          </label>
          <div className="flex gap-2 w-full">
            <input
              type_="text"
              autoFocus=true
              className="bg-gray-200 dark:bg-neutral-900 w-full p-2"
              ref={searchInputRef}
              required=true
            />
            <button
              className="bg-dark-blue dark:bg-aqua-blue dark:text-neutral-900 font-semibold text-white p-2 rounded-tr">
              {"Search"->React.string}
            </button>
          </div>
        </form>
        <div className="flex flex-col gap-4 mt-8">
          {switch (isPending, isError, data) {
          | (true, _, _) => <LoadingDots />
          | (_, true, _) => <CardNotFound error={error} />
          | (false, false, None) => <CardNotFound error={message: "Card not found"} />
          | (false, false, Some(data)) =>
            data.data
            ->Array.map(card => {
              <SearchCardItem
                id=card.id
                front=card.front
                back=card.back
                review_at=card.review_at
                reSearchCards={reSearchCards}
                key={card.id}
              />
            })
            ->React.array
          }}
        </div>
      </div>
    </section>
  </>
}
