export const formatInterval = (interval: number) => {
  if (interval >= 365) {
    const amount = interval / 365;
    const precision = Math.floor(((interval % 365) * 10) / 365);
    return `${Math.trunc(amount)}.${Math.trunc(precision)}y`;
  } else if (interval >= 30) {
    const amount = interval / 30;
    const precision = Math.floor(((interval % 30) * 10) / 30);
    return `${Math.trunc(amount)}.${Math.trunc(precision)}m`;
  } else {
    return `${interval}d`;
  }
};
