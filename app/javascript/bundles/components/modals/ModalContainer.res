type t = {
  children: React.element,
  isModalOpen: bool,
  setIsModalOpen: bool => unit,
}

@react.component
let make = (~children, ~isModalOpen, ~setIsModalOpen) => {
  let {isDialogOpen, dialogAnimationEnd, closeModal} = ModalContainerHook.useModalContainer(
    ~isModalOpen,
    ~setIsModalOpen,
  )

  <>
    <div
      className={`${isModalOpen
          ? "translate-y-0"
          : "translate-y-[-100%]"} fixed bottom-0 left-0 right-0 w-full h-full bg-[rgba(0,0,0,0.2)] z-10`}
      onClick={_ => closeModal()}
    />
    <dialog
      open_={isDialogOpen}
      onAnimationEnd={event => {dialogAnimationEnd(event)}}
      className={`fixed p-4 max-w-[500px] w-[95%] dark:bg-neutral-800 dark:text-white rounded top-0 z-10 ${isModalOpen
          ? "show-modal-animation"
          : "close-modal-animation"}`}>
      {children}
    </dialog>
  </>
}
