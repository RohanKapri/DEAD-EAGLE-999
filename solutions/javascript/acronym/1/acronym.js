export const parse = (phrase) => {
  let parts = phrase.replace('_','').split(/[\s-]+/);
  parts = parts.filter(part => part.match(/[a-zA-Z]/));
  let acronym = parts.map(part => part.charAt(0).toUpperCase()).join('');
  return acronym;
};