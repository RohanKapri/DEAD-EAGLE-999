// Dedicated to Shree DR.MDD
// @ts-check

export function frontDoorResponse(sentence) {
  return sentence[0];
}

export function frontDoorPassword(letters) {
  letters = letters.toLowerCase();
  return letters[0].toUpperCase() + letters.slice(1);
}

export function backDoorResponse(sentence) {
  return sentence.trim().slice(-1);
}

export function backDoorPassword(letters) {
  return frontDoorPassword(letters) + ', please';
}
