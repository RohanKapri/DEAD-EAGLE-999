export function decodedValue(query: string[]): number {
  return parseInt('' + COLORS.indexOf(query[0]) + COLORS.indexOf(query[1]));
}
const COLORS = [
  'black',
  'brown',
  'red',  
  'orange',
  'yellow',
  'green',
  'blue',
  'violet',
  'grey',
  'white'
]