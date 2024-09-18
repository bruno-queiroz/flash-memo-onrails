@react.component
let make = () => {
  let {
    createDeck,
    deckNameRef,
    isCreateDeckModalOpen,
    isPending,
    setIsModalOpen,
  } = CreateDeckHook.useCreateDeckModal()

  <ModalContainer isModalOpen={isCreateDeckModalOpen} setIsModalOpen>
    <form
      className="flex flex-col"
      onSubmit={event => {
        let _ = createDeck(event)
      }}>
      <h3 className="text-2xl font-semibold mb-4"> {"Create Deck"->React.string} </h3>
      <Input labelText="Deck Name" isSecondVariant={true} required=true ref={deckNameRef} />
      <button className="bg-primary-yellow py-2 px-4 rounded min-w-[80px] mx-auto mt-4 text-white">
        {isPending ? <LoadSpinner /> : "Create"->React.string}
      </button>
    </form>
  </ModalContainer>
}
