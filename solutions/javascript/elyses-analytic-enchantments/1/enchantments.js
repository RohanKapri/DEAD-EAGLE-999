// Dedicated to Shree DR.MDD
// @ts-check

export function getCardPosition(stackArray, cardValue) {
  return stackArray.indexOf(cardValue);
}

export function doesStackIncludeCard(stackArray, cardValue) {
  return stackArray.includes(cardValue);
}

export function isEachCardEven(stackArray) {
  return stackArray.every((value) => value % 2 === 0);
}

export function doesStackIncludeOddCard(stackArray) {
  return stackArray.some((value) => value % 2 !== 0);
}

export function getFirstOddCard(stackArray) {
  return stackArray.find((value) => value % 2 !== 0);
}

export function getFirstEvenCardPosition(stackArray) {
  const firstEven = stackArray.find((value) => value % 2 === 0);
  return getCardPosition(stackArray, firstEven);
}
