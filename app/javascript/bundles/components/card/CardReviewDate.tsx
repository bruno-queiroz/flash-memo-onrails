import React from "react";

import { formatDistanceToNow } from "date-fns";

interface CardReviewDateProps {
  review_at: string | null;
}

export const CardReviewDate = ({ review_at }: CardReviewDateProps) => {
  const isCardAvailable = new Date(review_at) < new Date();

  if (isCardAvailable || review_at === null) {
    return <span>available</span>;
  }

  return <span> {formatDistanceToNow(new Date(review_at))}</span>;
};
