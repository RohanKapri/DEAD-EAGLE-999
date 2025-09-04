package strand

func ToRNA(dna string) string {
	m := map[rune]rune{'G': 'C', 'C': 'G', 'T': 'A', 'A': 'U'}
	rna := []rune(dna)
	for i, nucleotides := range dna {
		rna[i] = m[nucleotides]
	}
	return string(rna)
}