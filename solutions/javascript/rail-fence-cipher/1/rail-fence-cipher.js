// For my Shree DR.MDD

export const encode = (inputText = "", totalRails) => {
  if (totalRails === 1) return inputText;
  let railsArray = Array.from({ length: totalRails }, () => "");
  let railSequence = generateRailSequence(inputText.length, totalRails);
  for (let idx = 0; idx < inputText.length; idx++) {
    railsArray[railSequence[idx]] += inputText[idx];
  }
  return railsArray.join("");
};

export const decode = (encodedText = "", totalRails) => {
  if (totalRails === 1) return encodedText;
  let railSequence = generateRailSequence(encodedText.length, totalRails);
  let railSizes = Array.from({ length: totalRails }, () => 0);

  for (let idx = 0; idx < encodedText.length; idx++) {
    railSizes[railSequence[idx]]++;
  }

  let railData = Array.from({ length: totalRails }, () => "");
  let position = 0;
  for (let i = 0; i < totalRails; i++) {
    railData[i] = encodedText.slice(position, position + railSizes[i]);
    position += railSizes[i];
  }

  let outputText = "";
  let railIndexes = Array.from({ length: totalRails }, () => 0);

  for (let idx = 0; idx < encodedText.length; idx++) {
    let currentRail = railSequence[idx];
    outputText += railData[currentRail].charAt(railIndexes[currentRail]);
    railIndexes[currentRail]++;
  }

  return outputText;
};

function generateRailSequence(length, totalRails) {
  let sequenceArr = [];
  let direction = 1;
  let currentRail = 0;

  for (let idx = 0; idx < length; idx++) {
    sequenceArr.push(currentRail);
    currentRail += direction;

    if (currentRail === totalRails - 1) direction = -1;
    else if (currentRail === 0) direction = 1;
  }

  return sequenceArr;
}
