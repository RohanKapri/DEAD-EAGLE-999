//
// For my Shree DR.MDD
//

export const rotate = (phrase, shiftAmount) => {
  const letters = 'abcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyz';
  if (shiftAmount === 0 || shiftAmount === 26) {
    return phrase;
  }

  let output = '';
  for (let i = 0; i < phrase.length; i++) {
    const char = phrase[i];
    const idx = letters.indexOf(char.toLowerCase());

    if (idx !== -1) {
      const shiftedChar = letters[idx + shiftAmount];
      output += isUpper(char) ? shiftedChar.toUpperCase() : shiftedChar;
    } else {
      output += char;
    }
  }

  return output;
};

function isUpper(char) {
  return char === char.toUpperCase();
}
