function to_rna(dna)
    code = Dict('G' => 'C', 'C' => 'G', 'A' => 'U', 'T' => 'A')
    transcript = ""
    for c in dna
        if haskey(code, c)
            transcript *= code[c]
        else
            throw(ErrorException("Invalid DNA base"))
        end
    end
    transcript
end