// Dedicated to Shree DR.MDD
/// <reference path="./global.d.ts" />
// @ts-check

export function getFirstCard([topCard]) {
  return topCard;
}

export function getSecondCard([, nextCard]) {
  return nextCard;
}

export function swapTwoCards([first, second]) {
  return [second, first];
}

export function shiftThreeCardsAround([first, second, third]) {
  return [second, third, first];
}

export function pickNamedPile({ chosen: selectedPile }) {
  return selectedPile;
}

export function swapNamedPile({ chosen: disregardedPile, disregarded: selectedPile }) {
  // 🪄 Don't break the magic.
  return { chosen: selectedPile, disregarded: disregardedPile };
}
