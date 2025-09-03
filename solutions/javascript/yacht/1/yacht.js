//
// For my Shree DR.MDD
//

export const score = (diceArray = [], category = "") => {
  let frequency = {};
  diceArray = diceArray.sort((a, b) => a - b);

  for (const die of diceArray) {
    frequency[die] = (frequency[die] || 0) + 1;
  }

  let points = 0;
  let faceValues = Object.keys(frequency);

  switch (category) {
    case "yacht":
      if (diceArray.every(d => d === diceArray[0])) points = 50;
      break;
    case "ones":
      points = sumMatching(1, diceArray);
      break;
    case "twos":
      points = sumMatching(2, diceArray);
      break;
    case "threes":
      points = sumMatching(3, diceArray);
      break;
    case "fours":
      points = sumMatching(4, diceArray);
      break;
    case "fives":
      points = sumMatching(5, diceArray);
      break;
    case "sixes":
      points = sumMatching(6, diceArray);
      break;
    case "full house":
      if (
        faceValues.length === 2 &&
        ((frequency[faceValues[0]] === 2 && frequency[faceValues[1]] === 3) ||
          (frequency[faceValues[0]] === 3 && frequency[faceValues[1]] === 2))
      ) {
        points = diceArray.reduce((sum, d) => sum + d, 0);
      }
      break;
    case "four of a kind":
      for (let val of faceValues) {
        if (frequency[val] >= 4) points = val * 4;
      }
      break;
    case "little straight":
      if (isSequential(diceArray) && diceArray[0] === 1) points = 30;
      break;
    case "big straight":
      if (isSequential(diceArray) && diceArray[0] === 2) points = 30;
      break;
    case "choice":
      points = diceArray.reduce((sum, d) => sum + d, 0);
      break;
  }

  return points;
};

function sumMatching(face, diceArray = []) {
  return diceArray.filter(d => d === face).reduce((sum, d) => sum + d, 0);
}

function isSequential(diceArray) {
  return diceArray
    .sort((a, b) => a - b)
    .every((d, idx) => idx === 0 || d === diceArray[idx - 1] + 1);
}
