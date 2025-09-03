export const flatten = (list) => {
  let result = [];
  for(const element of list) {
      if(Array.isArray(element)) {
        result = result.concat(flatten(element));
      } else if(element !== undefined && element !== null) {
        result.push(element);
      }
  }
  return result;
};