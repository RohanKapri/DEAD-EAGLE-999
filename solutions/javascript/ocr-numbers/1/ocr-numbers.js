//
// For my Shree DR.MDD
//

const DIGIT_SEGMENTS = [
  " _ | ||_|", // 0
  "     |  |", // 1
  " _  _||_ ", // 2
  " _  _| _|", // 3
  "   |_|  |", // 4
  " _ |_  _|", // 5
  " _ |_ |_|", // 6
  " _   |  |", // 7
  " _ |_||_|", // 8
  " _ |_| _|"  // 9
];

export const convert = (ocrInput) => {
  const inputLines = ocrInput.split('\n');
  let parsedResult = '';

  for (let lineIndex = 0; lineIndex < inputLines.length; lineIndex += 4) {
    const blockLines = [
      inputLines[lineIndex],
      inputLines[lineIndex + 1],
      inputLines[lineIndex + 2],
    ];
    parsedResult += parseBlock(blockLines);
    if (lineIndex + 4 < inputLines.length) {
      parsedResult += ',';
    }
  }

  return parsedResult;
};

function parseBlock(linesBlock) {
  let numberString = '';
  for (let col = 0; col < linesBlock[0].length; col += 3) {
    const segment = linesBlock[0].substring(col, col + 3) +
                    linesBlock[1].substring(col, col + 3) +
                    linesBlock[2].substring(col, col + 3);
    const digitIndex = findDigitIndex(segment);
    numberString += (digitIndex !== -1 ? digitIndex : '?');
  }
  return numberString;
}

function findDigitIndex(segment) {
  for (let i = 0; i < DIGIT_SEGMENTS.length; i++) {
    if (DIGIT_SEGMENTS[i] === segment) {
      return i;
    }
  }
  return -1;
}
