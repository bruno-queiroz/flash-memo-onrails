@react.component
let make = () => {
  let {
    closeModal,
    deleteSelectedDeck,
    isDeleteDeckModalOpen,
    isPending,
    selectedDeckTitle,
    setIsModalOpen,
  } = DeleteDeckHook.useDeckDeleteModal()

  <ModalContainer isModalOpen=isDeleteDeckModalOpen setIsModalOpen>
    <h3 className="text-2xl font-semibold mb-4"> {"Delete Deck"->React.string} </h3>
    <p>
      {"Do you want to"->React.string}
      <span className="text-primary-yellow">
        {" delete "->React.string}
        {selectedDeckTitle->React.string}
      </span>
      {" deck? You'll lose all cards created in this deck"->React.string}
    </p>
    <div className="flex gap-4 mt-4 justify-end">
      <button
        className="py-2 px-4 rounded bg-gray-300 dark:bg-neutral-700" onClick={_ => closeModal()}>
        {"Cancel"->React.string}
      </button>
      <button
        className="py-2 px-4 min-w-[78px] rounded bg-red-500 text-white"
        onClick={_ => {
          let _ = deleteSelectedDeck()
        }}
        disabled={isPending}>
        {isPending ? <LoadSpinner /> : "Delete"->React.string}
      </button>
    </div>
  </ModalContainer>
}
