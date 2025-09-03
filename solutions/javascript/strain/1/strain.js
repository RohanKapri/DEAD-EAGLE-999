export const keep = (data,callback) => {
  const result = []
  for (let i = 0; i < data.length; i++) {
      if (callback(data[i])) {
        result.push(data[i])
      }
  }
  return result; 
};

export const discard = (data,callback) => {
  return keep(data, (element) => !callback(element));
};