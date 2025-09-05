export function toRna(nucleotide: string): string {
  return nucleotide.split('').map((el:string)=> translate(el)).join('');
}
function translate(nucleotide: string): string {
  if (nucleotide == 'G') {
    return 'C';
  }
  if (nucleotide == 'C') {
    return 'G';
  }
  if (nucleotide == 'T') {
    return 'A';
  }
  if (nucleotide == 'A') {
    return 'U'; 
  }
  throw 'Invalid input DNA.';
}