export const formatText = (text: string | undefined) => {
  if (!text) return [""];
  const regex = /\n/g;
  const textSplittedOnNewLines = text.split(regex);
  return textSplittedOnNewLines;
};
