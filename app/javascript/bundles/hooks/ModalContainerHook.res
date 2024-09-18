type t = {
  closeModal: unit => unit,
  dialogAnimationEnd: JsxEventU.Animation.t => unit,
  isDialogOpen: bool,
}

let useModalContainer = (~isModalOpen: bool, ~setIsModalOpen: bool => unit) => {
  let (isDialogOpen, setIsDialogOpen) = React.useState(_ => false)

  let dialogAnimationEnd = (event: JsxEventU.Animation.t) => {
    let domEvent = (Obj.magic(event): WebApi.event)

    if domEvent.animationName === "close-modal-animation" {
      setIsDialogOpen(_ => false)
    }
  }

  let closeModal = () => {
    setIsModalOpen(false)
  }

  React.useEffect(() => {
    if isModalOpen {
      setIsDialogOpen(_ => true)
    }

    None
  }, [isModalOpen])

  {
    closeModal,
    dialogAnimationEnd,
    isDialogOpen,
  }
}
