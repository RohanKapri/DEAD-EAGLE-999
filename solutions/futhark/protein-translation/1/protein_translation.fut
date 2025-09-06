type amino_acid = #methionine | #phenylalanine | #leucine | #serine | #tyrosine | #cysteine | #tryptophan
def is (codon: [3]u8) (code: [3]u8): bool =
  codon[0] == code[0] && codon[1] == code[1] && codon[2] == code[2]
def stop (codon: [3]u8): bool =
  is codon "UAA" || is codon "UAG" || is codon "UGA"
def translate (codon: [3]u8): amino_acid =
  if is codon "AUG" then #methionine
  else if is codon "UUU" || is codon "UUC" then #phenylalanine
  else if is codon "UUA" || is codon "UUG" then #leucine
  else if is codon "UCU" || is codon "UCC" || is codon "UCA" || is codon "UCG"
  then #serine
  else if is codon "UAU" || is codon "UAC" then #tyrosine
  else if is codon "UGU" || is codon "UGC" then #cysteine
  else if is codon "UGG" then #tryptophan
  else assert false #methionine
def proteins (strand: []u8): []amino_acid =
  let (amino, _) =
    loop (amino, rna) =
      ([], strand)
      while length rna != 0 do
        assert (length rna >= 3)
        (if stop rna[:3] then (amino, [])
        else (amino ++ [translate rna[:3]], rna[3:]))
   in amino