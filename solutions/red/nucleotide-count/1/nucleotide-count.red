Red [
    description: {"Nucleotide Count" exercise solution for exercism platform"}
    author: "Rohan Kapri"
]
nucleotide-counts: function [
    strand [string!]
    return: [map!]
] [
    ; Initialize a map with each nucleotide count set to 0
    counts: make map! [A 0 C 0 G 0 T 0]
    
    ; Iterate over each character in the strand
    foreach nucleotide strand [
        ; Check if the character is a valid nucleotide
        if not find "ACGT" nucleotide [
            ; If it's not, raise an error
            cause-error 'user 'message "Invalid nucleotide in strand"
        ]
        ; If it's valid, increment the corresponding count in the map
        counts/(to-word nucleotide): counts/(to-word nucleotide) + 1
    ]
    ; Return the map with the counts
    return counts
]