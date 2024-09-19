@react.component
let make = () => {
  let {
    deckNameInputRef,
    isEditDeckNameModalOpen,
    onEditDeckName,
    setIsModalOpen,
  } = EditDeckHook.useEditDeckNameModal()

  <ModalContainer isModalOpen=isEditDeckNameModalOpen setIsModalOpen>
    <form
      className="flex flex-col gap-4"
      onSubmit={event => {
        let _ = onEditDeckName(event)
      }}>
      <h3 className="text-2xl font-semibold"> {"Edit Deck Name"->React.string} </h3>
      <Input labelText="Deck Name" isSecondVariant=true ref={deckNameInputRef} required=true />
      <div className="flex justify-end">
        <button
          className="py-2 px-4 w-[78px] font-semibold rounded dark:bg-neutral-700 bg-gray-200  dark:text-white">
          {"Edit"->React.string}
        </button>
      </div>
    </form>
  </ModalContainer>
}
