local codons = {
  AUG="Methionine",
  UUU="Phenylalanine",
  UUC="Phenylalanine",
  UUA="Leucine",
  UUG="Leucine",
  UCU="Serine",
  UCC="Serine",
  UCA="Serine",
  UCG="Serine",
  UAU="Tyrosine",
  UAC="Tyrosine",
  UGU="Cysteine",
  UGC="Cysteine",
  UGG="Tryptophan",
  UAA="STOP",
  UAG="STOP",
  UGA="STOP"
}
local function proteins(rna_strand)
  local list = {}
  for codon in rna_strand:gmatch("...") do
    local protein = assert(codons[codon], "Unknown Codon")
    if protein == "STOP" then break end
    table.insert(list, protein)
  end
  return list
end
return { proteins = proteins}