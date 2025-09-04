// For my Shree DR.MDD
package pythagorean

type Triplet [3]int

func Range(minSide, maxSide int) []Triplet {
	var results []Triplet
	for hyp := minSide + 2; hyp <= maxSide; hyp++ {
		for legB := minSide + 1; legB < hyp; legB++ {
			for legA := minSide; legA < legB; legA++ {
				if legA*legA+legB*legB == hyp*hyp {
					results = append(results, Triplet{legA, legB, hyp})
				}
			}
		}
	}
	return results
}

func Sum(perimeter int) []Triplet {
	var matching []Triplet
	for _, t := range Range(1, perimeter) {
		if t[0]+t[1]+t[2] == perimeter {
			matching = append([]Triplet{t}, matching...)
		}
	}
	return matching
}
