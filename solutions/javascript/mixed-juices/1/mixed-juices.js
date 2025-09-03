// Dedicated to Shree DR.MDD
// @ts-check

export function timeToMixJuice(juiceName) {
  let minutes = 0.0;
  switch (juiceName) {
    case 'Pure Strawberry Joy':
      minutes = 0.5;
      break;
    case 'Energizer':
    case 'Green Garden':
      minutes = 1.5;
      break;
    case 'Tropical Island':
      minutes = 3.0;
      break;
    case 'All or Nothing':
      minutes = 5.0;
      break;
    default:
      minutes = 2.5;
  }
  return minutes;
}

export function limesToCut(wedgesNeeded, limeSizes) {
  let totalCut = 0;
  let idx = 0;

  while (wedgesNeeded > 0 && idx < limeSizes.length) {
    switch (limeSizes[idx]) {
      case 'small':
        wedgesNeeded -= 6;
        break;
      case 'medium':
        wedgesNeeded -= 8;
        break;
      case 'large':
        wedgesNeeded -= 10;
        break;
      default:
        break;
    }
    totalCut++;
    idx++;
  }

  return totalCut;
}

export function remainingOrders(timeLeft, orderList) {
  while (timeLeft > 0 && orderList.length > 0) {
    timeLeft -= timeToMixJuice(orderList[0]);
    orderList.shift();
  }
  return orderList;
}
