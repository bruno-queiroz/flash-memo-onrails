@react.component
let make = () => {
  let {decks, isError, isPending, openCreateDeckModal} = DeckHook.useDecks()

  <section className="flex flex-col gap-6 items-center p-4 dark:text-gray-300 min-h-screen">
    <DeleteDeckModal />
    <CreateDeckModal />
    <EditDeckNameModal />
    <h1 className="font-bold text-center text-4xl text-neutral-800 dark:text-white">
      {"Decks"->React.string}
    </h1>
    <div className="flex flex-col gap-2 max-w-[1000px] w-full">
      {switch (isPending, isError, decks) {
      | (true, _, _) => <DeckSkeleton />
      | (_, true, _) => <DeckMessage message="Something went wrong" />
      | (false, false, None) => <DeckMessage message="Something went wrong" />
      | (false, false, Some(decks)) =>
        switch decks.data {
        | [] => <DeckMessage message="No decks available" />
        | _ =>
          decks.data
          ->Belt.Array.map(deck => {
            <DeckStatus
              key={deck.id}
              title={deck.title}
              id={deck.id}
              new_cards={deck.new_cards}
              reset_cards={deck.reset_cards}
              review_cards={deck.review_cards}
            />
          })
          ->React.array
        }
      }}
    </div>
    <button
      type_="button"
      disabled={isPending}
      className="bg-primary-yellow py-2 px-4 rounded w-[max-content] mx-auto mt-4 text-white font-semibold"
      onClick={_ => openCreateDeckModal()}>
      {"Create Deck"->React.string}
    </button>
  </section>
}
