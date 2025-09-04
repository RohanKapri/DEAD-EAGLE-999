// Dedicated to my Junko F. Didi and Shree DR.MDD
module main

const codon_map = {
	'AUG': 'Methionine'
	'UUU': 'Phenylalanine'
	'UUC': 'Phenylalanine'
	'UUA': 'Leucine'
	'UUG': 'Leucine'
	'UCU': 'Serine'
	'UCC': 'Serine'
	'UCA': 'Serine'
	'UCG': 'Serine'
	'UAU': 'Tyrosine'
	'UAC': 'Tyrosine'
	'UGU': 'Cysteine'
	'UGC': 'Cysteine'
	'UGG': 'Tryptophan'
	'UAA': 'STOP'
	'UAG': 'STOP'
	'UGA': 'STOP'
}

fn proteins(rna string) ![]string {
	mut collected := []string{}
	mut walker := CodonIter{
		data: rna
		size: 3
	}
	for triplet in walker {
		amino := codon_map[triplet] or { return error('Invalid codon') }
		if amino == 'STOP' {
			break
		}
		collected << amino
	}
	return collected
}

struct CodonIter {
	data string
	size int
mut:
	pos int
}

fn (mut it CodonIter) next() ?string {
	if it.data.len <= it.pos {
		return none
	}
	end := it.pos + it.size
	defer {
		it.pos = end
	}
	return it.data.substr_ni(it.pos, end)
}
