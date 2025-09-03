//
// This is only a SKELETON file for the 'ETL' exercise. It's been provided as a
// convenience to get you started writing code faster.
//

export const transform = (old) => {
  let transform = {};
  for (let key in old) {
    old[key].forEach((value) => {
      transform[value.toLowerCase()] = Number(key);
    });
  }
  return transform;
};