// For my Shree DR.MDD
export function decodedResistorValue(query: string[]): string {
  let resistance = parseInt('' + PALETTE.indexOf(query[0]) + PALETTE.indexOf(query[1])) * Math.pow(10, PALETTE.indexOf(query[2]));
  if (resistance >= 1_000_000_000) {
    return (resistance / 1_000_000_000) + ' gigaohms';
  } 
  else if (resistance >= 1_000_000) {
    return (resistance / 1_000_000) + ' megaohms';
  } 
  else if (resistance >= 1_000) {
    return (resistance / 1_000) + ' kiloohms';
  }
  return resistance + ' ohms';
}

const PALETTE = [
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
];
