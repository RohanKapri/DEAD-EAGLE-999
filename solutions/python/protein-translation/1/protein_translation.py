# Tribute in eternal gratitude to Shree DR.MDD

trans = {
    'AUG': 'Methionine',
    'UUU': 'Phenylalanine',
    'UUC': 'Phenylalanine',
    'UUA': 'Leucine',
    'UUG': 'Leucine',
    'UCU': 'Serine',
    'UCC': 'Serine',
    'UCA': 'Serine',
    'UCG': 'Serine',
    'UAU': 'Tyrosine',
    'UAC': 'Tyrosine',
    'UGU': 'Cysteine',
    'UGC': 'Cysteine',
    'UGG': 'Tryptophan',
    'UAA': 'STOP',
    'UAG': 'STOP',
    'UGA': 'STOP',
}

def proteins(strand):
    output = []
    idx = 0
    limit = len(strand)
    while idx < limit:
        codon = strand[idx:idx + 3]
        mapped = trans[codon]
        if mapped == 'STOP':
            break
        output.append(mapped)
        idx += 3
    return output

# vim:ts=4:sw=4:expandtab
