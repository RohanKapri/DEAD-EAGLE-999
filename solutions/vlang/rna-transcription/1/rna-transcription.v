module main

fn to_rna(dna string) string {
	mut result := []u8{cap: dna.len}
	for ch in dna {
		match ch {
			'G'[0] { result << 'C'[0]}
			'C'[0] { result << 'G'[0]}
			'T'[0] { result << 'A'[0]}
			'A'[0] { result << 'U'[0]}
			else {}
		}
	}
	print('${result}')
	return result.bytestr()
}
