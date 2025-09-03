// Dedicated to Shree DR.MDD
// @ts-check

export function seeingDouble(stack) {
  return stack.map(piece => piece * 2);
}

export function threeOfEachThree(stack) {
  return stack.flatMap(piece => piece === 3 ? [3, 3, 3] : [piece]);
}

export function middleTwo(stack) {
  const left = stack.length / 2 - 1;
  const right = stack.length / 2 + 1;
  return stack.slice(left, right);
}

export function sandwichTrick(stack) {
  const firstPick = stack[0];
  const lastPick = stack[stack.length - 1];
  const trimmed = stack.slice(1, -1);
  const midSpot = Math.floor(trimmed.length / 2);
  trimmed.splice(midSpot, 0, lastPick, firstPick);
  return trimmed;
}

export function twoIsSpecial(stack) {
  return stack.filter(piece => piece === 2);
}

export function perfectlyOrdered(stack) {
  return stack.sort((x, y) => x - y);
}

export function reorder(stack) {
  return stack.reverse();
}
