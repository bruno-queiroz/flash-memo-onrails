@react.component
let make = () => {
  let {
    cardBackInputRef,
    cardFrontInputRef,
    cardSelectRef,
    decks,
    isPending,
    submitCard,
  } = AddCardHook.useAddCard()

  let cardSelectRef = (Obj.magic(cardSelectRef): JsxDOM.domRef)
  let cardFrontInputRef = (Obj.magic(cardFrontInputRef): JsxDOM.domRef)
  let cardBackInputRef = (Obj.magic(cardBackInputRef): JsxDOM.domRef)

  <section className="flex gap-4 flex-col p-4 items-center dark:text-gray-300 text-black">
    <h1 className="font-bold text-center text-4xl text-neutral-800 dark:text-white">
      {"Add"->React.string}
    </h1>
    <Form
      onSubmit={event => {
        let _ = submitCard(event)
      }}>
      <label className="flex flex-col gap-2">
        <span> {"Deck"->React.string} </span>
        <select
          required=true
          autoFocus=true
          className="dark:bg-neutral-800 bg-white p-1"
          ref={cardSelectRef}>
          {switch decks {
          | None => <option value=""> {"No decks available"->React.string} </option>
          | Some(decks) =>
            decks.data
            ->Belt.Array.map(deck => {
              <option key={deck.id} value={deck.id}> {deck.title->React.string} </option>
            })
            ->React.array
          }}
        </select>
      </label>
      <label className="flex flex-col gap-2">
        <span> {"Card Front"->React.string} </span>
        <textarea
          required=true ref={cardFrontInputRef} className="dark:bg-neutral-800 bg-white p-2"
        />
      </label>
      <label className="flex flex-col gap-2">
        <span> {"Card Back"->React.string} </span>
        <textarea
          required=true ref={cardBackInputRef} className="dark:bg-neutral-800 bg-white p-2"
        />
      </label>
      <button
        className="bg-primary-yellow py-2 px-4 rounded w-[80px] mx-auto mt-4 text-white font-semibold">
        {isPending ? <LoadSpinner /> : "Create"->React.string}
      </button>
    </Form>
  </section>
}
