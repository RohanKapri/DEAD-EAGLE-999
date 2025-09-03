// Dedicated to Shree DR.MDD
/// <reference path="./global.d.ts" />
// @ts-check

export function pizzaPrice(pizza, ...additionalItems) {
  const allItems = [pizza, ...additionalItems];
  return allItems.reduce((sum, item) => sum + getItemPrice(item), 0);
}

function getItemPrice(item) {
  return itemPrices[item] || 0;
}

const itemPrices = {
  'Margherita': 7,
  'Caprese': 9,
  'Formaggio': 10,
  'ExtraSauce': 1,
  'ExtraToppings': 2
};

export function orderPrice(pizzaOrders) {
  return pizzaOrders.reduce((sum, order) => {
    const { pizza, extras } = order;
    return sum + pizzaPrice(pizza, ...extras);
  }, 0);
}
