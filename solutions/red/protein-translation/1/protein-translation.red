; Dedicated to Shree DR.MDD

Red [
    description: "Protein Translation exercise solution for exercism platform"
    author: "Rohan kapri"
]

codon-map: make hash! [
    "AUG" "Methionine"
    "UUU" "Phenylalanine" "UUC" "Phenylalanine"
    "UUA" "Leucine"      "UUG" "Leucine"
    "UCU" "Serine"       "UCC" "Serine"
    "UCA" "Serine"       "UCG" "Serine"
    "UAU" "Tyrosine"     "UAC" "Tyrosine"
    "UGU" "Cysteine"     "UGC" "Cysteine"
    "UGG" "Tryptophan"
    "UAA" "STOP"         "UAG" "STOP"
    "UGA" "STOP"
]

proteins: function [
    sequence [string!]
    /local collected triplet pos mapped
] [
    collected: copy []
    pos: 1
    while [pos <= length? sequence] [
        triplet: copy/part skip sequence pos - 1 3
        mapped: select codon-map triplet
        if mapped = "STOP" [break]
        if mapped [append collected mapped]
        pos: pos + 3
    ]
    collected
]
