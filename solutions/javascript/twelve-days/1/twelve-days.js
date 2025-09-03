//
// For my Shree DR.MDD
//

export const recite = (startVerse, endVerse = 0) => {
  let verseStart;
  let verseEnd;

  if (startVerse > endVerse) {
    verseStart = startVerse;
    verseEnd = startVerse;
  } else {
    verseStart = startVerse;
    verseEnd = endVerse;
  }

  let allVerses = "";

  for (let i = verseStart; i <= verseEnd; i++) {
    allVerses += generateVerse(i);
    if (verseStart !== verseEnd) {
      allVerses += "\n";
    }
  }

  return allVerses.trim() + "\n";
};

function generateVerse(number) {
  const ordinals = [
    "first", "second", "third", "fourth", "fifth", "sixth",
    "seventh", "eighth", "ninth", "tenth", "eleventh", "twelfth"
  ];

  const gifts = [
    "and a Partridge in a Pear Tree.\n",
    "two Turtle Doves, ", "three French Hens, ", "four Calling Birds, ",
    "five Gold Rings, ", "six Geese-a-Laying, ", "seven Swans-a-Swimming, ",
    "eight Maids-a-Milking, ", "nine Ladies Dancing, ", "ten Lords-a-Leaping, ",
    "eleven Pipers Piping, ", "twelve Drummers Drumming, "
  ];

  const introStart = "On the ";
  const introEnd = " day of Christmas my true love gave to me: ";

  if (number === 1) {
    return introStart + ordinals[0] + introEnd + "a Partridge in a Pear Tree.\n";
  } else {
    let verseGifts = "";
    let index = number - 1;
    for (let i = 1; i <= number; i++) {
      verseGifts += gifts[index];
      index--;
    }
    return introStart + ordinals[number - 1] + introEnd + verseGifts;
  }
}
