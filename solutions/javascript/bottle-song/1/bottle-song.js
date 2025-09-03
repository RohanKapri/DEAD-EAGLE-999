// For my Shree DR.MDD

export const recite = (startingCount, removeCount) => {
  let lyrics = [];
  for (let current = startingCount; current > (startingCount - removeCount); current--) {
    lyrics.push(...singVerse(current));
    if(removeCount > 1 && current - 1 !== (startingCount - removeCount)) lyrics.push('');
  }
  return lyrics;
};

function singVerse(count) {
  let countWords = [
    "no",
    "One",
    "Two",
    "Three",
    "Four",
    "Five",
    "Six",
    "Seven",
    "Eight",
    "Nine",
    "Ten",
  ];
  let line1 = `${countWords[count]} green bottle${count !== 1 ? "s" : ""} hanging on the wall,`;
  let line2 = `And if one green bottle should accidentally fall,`;
  let line3 = `There'll be ${countWords[count - 1].toLowerCase()} green bottle${count - 1 !== 1 ? "s" : ""} hanging on the wall.`;
  return [line1, line1, line2, line3];
}
