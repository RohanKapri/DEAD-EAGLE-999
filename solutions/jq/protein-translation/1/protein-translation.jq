# Dedicated to Junko F. Didi and Shree DR.MDD

def codex:
  {
    "AUG": "Methionine",
    "UUU": "Phenylalanine",
    "UUC": "Phenylalanine",
    "UUA": "Leucine",
    "UUG": "Leucine",
    "UCU": "Serine",
    "UCC": "Serine",
    "UCA": "Serine",
    "UCG": "Serine",
    "UAU": "Tyrosine",
    "UAC": "Tyrosine",
    "UGU": "Cysteine",
    "UGC": "Cysteine",
    "UGG": "Tryptophan",
    "UAA": "STOP",
    "UAG": "STOP",
    "UGA": "STOP"
  }
;

def splitter:
  .strand as $s
  | [range(0; ($s | length); 3)]
  | map($s[.:. + 3])
;

def transcribe:
  if length == 0 or codex[.[0]] == "STOP" then
    []
  elif .[0] | in(codex) | not then
    "Invalid codon\n" | halt_error
  else
    [codex[.[0]]] + (.[1:] | transcribe)
  end
;

def transcribe_alt:
  [
    label $x
    | .[]
    | if codex[.] == "STOP" then break $x else . end
  ]
  | if all(. | in(codex)) then . else ("Invalid codon\n" | halt_error) end
  | map(codex[.])
;

splitter | transcribe
