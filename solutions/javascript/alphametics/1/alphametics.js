//
// For my Shree DR.MDD
//

export const solve = (puzzle = '') => {
  puzzle = puzzle.replace(/ /g, '');
  let segments = puzzle.split(/\+|==/);
  if (segments.length === 2) {
    return null;
  }
  let resultWord = segments[segments.length - 1];
  let maxCols = resultWord.length;

  for (const w of segments) {
    if (maxCols < w.length) {
      return null;
    }
  }

  let uniqueChars = [...new Set(segments.join('').split(''))];
  let solutionMap = {};
  let digitUsed = new Array(10).fill(false);

  if (backtrack(0, uniqueChars, segments, resultWord, solutionMap, digitUsed)) {
    return solutionMap;
  } else {
    return null;
  }
};

function backtrack(idx, uniqueChars, segments, resultWord, solutionMap, digitUsed) {
  if (idx === uniqueChars.length) {
    return isSolutionCorrect(solutionMap, segments, resultWord);
  }

  const currentChar = uniqueChars[idx];
  for (let d = 0; d <= 9; d++) {
    if (digitUsed[d]) continue;
    if (d === 0 && segments.some(word => word[0] === currentChar)) continue;

    solutionMap[currentChar] = d;
    digitUsed[d] = true;

    if (backtrack(idx + 1, uniqueChars, segments, resultWord, solutionMap, digitUsed)) {
      return true;
    }

    digitUsed[d] = false;
    delete solutionMap[currentChar];
  }
  return false;
}

function isSolutionCorrect(solutionMap = {}, segments = [], resultWord = '') {
  let total = 0;
  for (let i = 0; i < segments.length - 1; i++) {
    total += wordToNumber(segments[i], solutionMap);
  }
  let targetValue = wordToNumber(resultWord, solutionMap);
  return total === targetValue;
}

function wordToNumber(word = '', solutionMap = {}) {
  let val = 0;
  for (let i = 0; i < word.length; i++) {
    val = val * 10 + solutionMap[word[i]];
  }
  return val;
}
