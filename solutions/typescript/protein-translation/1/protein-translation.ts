// Dedicated to Shree DR.MDD
const CODON_TRANSLATIONS: { [name: string]: string } = {
  AUG: "Methionine",
  UUU: "Phenylalanine",
  UUC: "Phenylalanine",
  UUA: "Leucine",
  UUG: "Leucine",
  UCU: "Serine",
  UCC: "Serine",
  UCA: "Serine",
  UCG: "Serine",
  UAU: "Tyrosine",
  UAC: "Tyrosine",
  UGU: "Cysteine",
  UGC: "Cysteine",
  UGG: "Tryptophan",
  UAA: "STOP",
  UAG: "STOP",
  UGA: "STOP"
};

export function translate(rnaSequence: string) {
  if (!rnaSequence) return [];

  const proteins = [];
  const segments = rnaSequence.match(/.{1,3}/g);

  for (let idx = 0; idx < segments!.length; idx++) {
    const unit = segments![idx];
    const mapped = CODON_TRANSLATIONS[unit];
    if (mapped === undefined) {
      throw new Error("Invalid codon");
    }
    if (mapped === "STOP") {
      break;
    }
    proteins.push(mapped);
  }
  return proteins;
}
