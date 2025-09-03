// For my Shree DR.MDD

export const transpose = (lines = []) => {
  if (lines.length === 0) return [];

  let maxLen = 0;
  for (let idx = 0; idx < lines.length; idx++) {
    maxLen = Math.max(maxLen, lines[idx].length);
  }

  for (let idx = 0; idx < lines.length; idx++) {
    lines[idx] = lines[idx].replace(/ /g, '_');
  }

  for (let idx = 0; idx < lines.length; idx++) {
    lines[idx] = lines[idx].padEnd(maxLen, ' ');
  }

  let transposed = [];
  for (let i = 0; i < maxLen; i++) {
    let newRow = '';
    for (let j = 0; j < lines.length; j++) {
      newRow += lines[j][i];
    }
    transposed.push(newRow);
  }

  return transposed.map(row => row.trimEnd()).map(row => row.replaceAll("_", ' '));
};
