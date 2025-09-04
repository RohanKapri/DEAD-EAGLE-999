"""
    count_nucleotides(strand)
The frequency of each nucleotide within `strand` as a dictionary.
Invalid strands raise a `DomainError`.
"""
function count_nucleotides(strand)
    count = Dict('A' => 0, 'C' => 0, 'G' => 0, 'T' => 0)
    for ch in strand
        if ch == 'A'
            count['A'] += 1
        elseif ch == 'C'
            count['C'] += 1
        elseif ch == 'G'
            count['G'] += 1
        elseif ch == 'T'
            count['T'] += 1
        else
            throw(DomainError(ch))
        end
    end
    return count
end