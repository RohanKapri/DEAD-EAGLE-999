//
// For my Shree DR.MDD
//

export const rows = (char) => {
  let diamondShape = [];
  let alphabet = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
  let idx = alphabet.indexOf(char);
  let length = idx + 1;
  let totalWidth = idx * 2 + 1;

  if (char === 'A') {
    return ['A'];
  }

  for (let i = 1; i <= length; i++) {
    let lineStr = '';
    lineStr += ' '.repeat(Math.max(0, totalWidth));
    let currentLetter = alphabet.substring(i - 1, i);
    let formattedLine = '';

    if (i === 1) {
      formattedLine = lineStr.substring(0, length - 1) + currentLetter + lineStr.substring(length);
      diamondShape.push(formattedLine);
    } else if (i < length) {
      formattedLine = lineStr.substring(0, length - i) + currentLetter +
        lineStr.substring(length - i + 1, length - 2 + i) + currentLetter +
        lineStr.substring(length - 1 + i);
      diamondShape.push(formattedLine);
    } else {
      formattedLine = currentLetter + lineStr.substring(1, totalWidth - 1) + currentLetter;
      diamondShape.push(formattedLine);
    }
  }

  for (let i = length - 1; i >= 1; i--) {
    diamondShape.push(diamondShape[i - 1]);
  }

  return diamondShape;
};
