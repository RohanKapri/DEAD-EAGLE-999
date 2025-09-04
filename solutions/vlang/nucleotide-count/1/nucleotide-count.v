module main

fn count_nucleotides(strand string) !map[string]int {
  mut result := { 
		'A': 0
		'C': 0
		'G': 0
		'T': 0
	}
  for n in strand {
    ns := rune(n).str()
    if ns in result {
      result[ns]++
    } else {
      return error('${ns} is not a valid nucleotide!')
    }
	}
  return result
}
