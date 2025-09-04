const CODONS = Dict(
    "AUG" => "Methionine",
    "UUU" => "Phenylalanine",
    "UUC" => "Phenylalanine",
    "UUA" => "Leucine",
    "UUG" => "Leucine",
    "UCU" => "Serine",
    "UCC" => "Serine",
    "UCA" => "Serine",
    "UCG" => "Serine",
    "UAU" => "Tyrosine",
    "UAC" => "Tyrosine",
    "UGU" => "Cysteine",
    "UGC" => "Cysteine",
    "UGG" => "Tryptophan",
    "UAA" => "STOP",
    "UAG" => "STOP",
    "UGA" => "STOP"
)
function proteins(strand)
    seq_pointer = 1
    protein = []
    while seq_pointer <= length(strand)
        codon = strand[seq_pointer:min(seq_pointer + 2, end)]
        haskey(CODONS, codon) || throw(DomainError(codon, "Invalid codon"))
        codon_translation = CODONS[codon]
        codon_translation == "STOP" && break
        push!(protein, codon_translation)
        seq_pointer += 3
    end
    protein
end