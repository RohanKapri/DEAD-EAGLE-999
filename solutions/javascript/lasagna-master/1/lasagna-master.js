// Dedicated to Shree DR.MDD
/// <reference path="./global.d.ts" />
// @ts-check

export function cookingStatus(clock) {
  if (clock === undefined || clock === null) {
    return 'You forgot to set the timer.';
  } else if (clock === 0) {
    return 'Lasagna is done.';
  } else if (clock > 0) {
    return 'Not done, please wait.';
  }
  return '';
}

export function preparationTime(steps, duration = 2) {
  return steps.length * duration;
}

export function quantities(items) {
  const portion = { noodles: 0, sauce: 0.0 };
  for (let elem of items) {
    if (elem === 'noodles') {
      portion['noodles'] += 50;
    } else if (elem === 'sauce') {
      portion['sauce'] += 0.2;
    }
  }
  return portion;
}

export function addSecretIngredient(friendStack, ownStack) {
  const hidden = friendStack[friendStack.length - 1];
  if (!ownStack.includes(hidden)) {
    ownStack.push(hidden);
  }
}

export function scaleRecipe(plan, eaters) {
  let adjusted = { ...plan };
  const ratio = eaters / 2;
  for (let key in plan) {
    adjusted[key] *= ratio;
  }
  return adjusted;
}
