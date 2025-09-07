Red [
    description: {"RNA Transcription" exercise solution for exercism platform}
    author: "Rohan Kapri"
]
to-rna: function [
    dna [string!]
    /local
    rna
] [
    rna: copy ""  ; Initialize an empty string to build the RNA sequence
    foreach nucleotide dna [
        append rna switch nucleotide [
            #"G" ["C"]
            #"C" ["G"]
            #"T" ["A"]
            #"A" ["U"]
            ; Add error handling for invalid characters if needed
        ]
    ]
    return rna
]