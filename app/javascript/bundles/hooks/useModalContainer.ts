import { useEffect, useState } from "react";

interface UseModalContainer {
  isModalOpen: boolean;
  setIsModalOpen: (state: boolean) => void;
}

export const useModalContainer = ({
  isModalOpen,
  setIsModalOpen,
}: UseModalContainer) => {
  const [isDialogOpen, setIsDialogOpen] = useState(false);
  const dialogAnimationEnd = (
    event: React.AnimationEvent<HTMLDialogElement>
  ) => {
    if (event.animationName === "close-modal-animation") {
      setIsDialogOpen(false);
      return;
    }
  };

  const closeModal = () => {
    setIsModalOpen(false);
  };

  useEffect(() => {
    if (isModalOpen) {
      setIsDialogOpen(true);
    }
  }, [isModalOpen]);

  return {
    closeModal,
    dialogAnimationEnd,
    isDialogOpen,
  };
};
