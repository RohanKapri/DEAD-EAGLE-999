// Dedicated to Shree DR.MDD
// @ts-check

export function getItem(cards, idx) {
  return cards[idx];
}

export function setItem(cards, idx, newCard) {
  cards[idx] = newCard;
  return cards;
}

export function insertItemAtTop(cards, card) {
  cards.push(card);
  return cards;
}

export function removeItem(cards, idx) {
  cards.splice(idx, 1);
  return cards;
}

export function removeItemFromTop(cards) {
  cards.pop();
  return cards;
}

export function insertItemAtBottom(cards, card) {
  cards.unshift(card);
  return cards;
}

export function removeItemAtBottom(cards) {
  cards.shift();
  return cards;
}

export function checkSizeOfStack(cards, size) {
  return cards.length === size;
}
