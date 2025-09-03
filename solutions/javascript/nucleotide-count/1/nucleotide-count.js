
export function countNucleotides(strand) {
  if (/.*[^ACGT].*/.test(strand)) {
    throw new Error("Invalid nucleotide in strand");
  }
  let nucleotideCount = {
    A: 0,
    C: 0,
    G: 0,
    T: 0,
  };
  for (let i = 0; i < strand.length; i++) {
    nucleotideCount[strand[i]]++;
  }
  let result = "";
  for (const key in nucleotideCount) {
    result += nucleotideCount[key] + " ";
  }
  return result.trim();
}