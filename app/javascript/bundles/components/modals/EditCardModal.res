@react.component
let make = (~reSearchCards) => {
  let {
    cardBackInputRef,
    cardFrontInputRef,
    editCard,
    isEditCardLoading,
    isEditCardModalOpen,
    setIsModalOpen,
  } = EditCardHook.useEditCardModal(reSearchCards)

  let cardFrontInputRef = (Obj.magic(cardFrontInputRef): JsxDOM.domRef)
  let cardBackInputRef = (Obj.magic(cardBackInputRef): JsxDOM.domRef)

  <ModalContainer setIsModalOpen isModalOpen=isEditCardModalOpen>
    <Form
      className="flex flex-col items-center gap-4"
      onSubmit={event => {
        let _ = editCard(event)
      }}>
      <h2 className="font-semibold text-center text-2xl text-neutral-800 dark:text-white">
        {"Edit Card"->React.string}
      </h2>
      <label className="flex flex-col gap-2 w-full">
        <span> {"Card Front"->React.string} </span>
        <textarea
          required=true ref={cardFrontInputRef} className="dark:bg-neutral-900 bg-gray-200 p-2"
        />
      </label>
      <label className="flex flex-col gap-2 w-full">
        <span> {"Card Back"->React.string} </span>
        <textarea
          required=true ref={cardBackInputRef} className="dark:bg-neutral-900 bg-gray-200 p-2"
        />
      </label>
      <button className="bg-primary-yellow py-2 px-4 rounded w-[80px] mx-auto mt-4 text-white">
        {isEditCardLoading ? <LoadSpinner /> : "Edit"->React.string}
      </button>
    </Form>
  </ModalContainer>
}
