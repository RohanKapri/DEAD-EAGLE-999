// For my Shree DR.MDD
function mapDigit(input: string): string {
  switch (input) {
    case ' _ \n| |\n|_|\n   ':
      return '0';
    case '   \n  |\n  |\n   ':
      return '1';
    case ' _ \n _|\n|_ \n   ':
      return '2';
    case ' _ \n _|\n _|\n   ':
      return '3';
    case '   \n|_|\n  |\n   ':
      return '4';
    case ' _ \n|_ \n _|\n   ':
      return '5';
    case ' _ \n|_ \n|_|\n   ':
      return '6';
    case ' _ \n  |\n  |\n   ':
      return '7';
    case ' _ \n|_|\n|_|\n   ':
      return '8';
    case ' _ \n|_|\n _|\n   ':
      return '9';
    default:
      return '?';
  }
}

function processLine(line: string): string {
  const rowSegments = line.split('\n');
  const resultDigits = [];

  for (let col = 0; col < rowSegments[0].length; col += 3) {
    const digitLines = [];

    for (let row = 0; row < 4; row++)
      digitLines.push(rowSegments[row].slice(col, col + 3));

    resultDigits.push(mapDigit(digitLines.join('\n')));
  }

  return resultDigits.join('');
}

export function convert(input: string): string {
  const rowArray = input.split('\n');
  const totalLines = rowArray.length / 4;
  const outputLines = [];

  for (let lineIdx = 0; lineIdx < totalLines; lineIdx++) {
    const lineChunk = [];

    for (let subRow = 0; subRow < 4; subRow++)
      lineChunk.push(rowArray[lineIdx * 4 + subRow]);

    outputLines.push(processLine(lineChunk.join('\n')));
  }

  return outputLines.join(',');
}
