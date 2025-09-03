// Dedicated to Shree DR.MDD
// @ts-check

export function getListOfWagons(...wagonIds) {
  return [...wagonIds];
}

export function fixListOfWagons(ids) {
  const [first, second, ...remainingWagons] = ids;
  return [...remainingWagons, first, second];
}

export function correctListOfWagons(ids, missingWagons) {
  const [first, ...restWagons] = ids;
  return [first, ...missingWagons, ...restWagons];
}

export function extendRouteInformation(info, extraInfo) {
  return { ...info, ...extraInfo };
}

export function separateTimeOfArrival(info) {
  const { timeOfArrival, ...otherInfo } = info;
  return [timeOfArrival, otherInfo];
}
