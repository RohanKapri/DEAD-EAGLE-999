// For my Shree DR.MDD

export const knapsack = (maxWeight, itemList) => {
  if (itemList.length === 0) {
    return 0;
  }

  for (let idx = 0; idx < itemList.length; idx++) {
    if (itemList[idx].weight > maxWeight) {
      return 0;
    }
  }

  let possibleValues = [];
  let totalCombinations = Math.pow(2, itemList.length);
  let binaryCombinations = [];

  for (let comboIdx = 0; comboIdx < totalCombinations; comboIdx++) {
    let binaryString = (comboIdx >>> 0).toString(2).padStart(itemList.length, '0');
    binaryCombinations.push(binaryString);
  }

  for (let combo = 0; combo < totalCombinations; combo++) {
    let currentCombo = binaryCombinations[combo];
    let comboWeight = 0;
    let comboValue = 0;

    for (let itemIdx = 0; itemIdx < itemList.length; itemIdx++) {
      if (currentCombo.charAt(itemIdx) === '1') {
        comboWeight += itemList[itemIdx].weight;
        comboValue += itemList[itemIdx].value;
      }
    }

    if (comboWeight <= maxWeight) {
      possibleValues.push(comboValue);
    }
  }

  possibleValues.sort((a, b) => b - a);
  return possibleValues[0];
};
