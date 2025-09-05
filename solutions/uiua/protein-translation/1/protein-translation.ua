ProteinMap ← map°⊟⍉ [
  {"AUG" "Methionine"}
  {"UUU" "Phenylalanine"}
  {"UUC" "Phenylalanine"}
  {"UUA" "Leucine"}
  {"UUG" "Leucine"}
  {"UCU" "Serine"}
  {"UCC" "Serine"}
  {"UCA" "Serine"}
  {"UCG" "Serine"}
  {"UAU" "Tyrosine"}
  {"UAC" "Tyrosine"}
  {"UGU" "Cysteine"}
  {"UGC" "Cysteine"}
  {"UGG" "Tryptophan"}
]
CutSeq ← |1 ↙⬚∞⊢⊚/↥⊸⊞≍["UAA" "UAG" "UGA"]
Proteins ← (|1
  CutSeq⬚@ ↯∞_3
  ⊸(=0⊢△)
  ⨬(⍣(≡get:¤ProteinMap) "invalid codon"
  | {}
  )
)