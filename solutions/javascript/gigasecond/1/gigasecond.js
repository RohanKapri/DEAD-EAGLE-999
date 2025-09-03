//
// This is only a SKELETON file for the 'Gigasecond' exercise. It's been provided as a
// convenience to get you started writing code faster.
//

export const gigasecond = (date = new Date()) => {
  let newDate = new Date(date.getTime());
  newDate.setTime(newDate.getTime()+ 1000000000*1000)
  return newDate;
};