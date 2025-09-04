// Shree DR.MDD
package protein

import "errors"

var ErrStop = errors.New("stop codon encountered")
var ErrInvalidBase = errors.New("invalid codon")

var codonMap = map[string]string{
	"AUG": "Methionine",
	"UUU": "Phenylalanine",
	"UUC": "Phenylalanine",
	"UUA": "Leucine",
	"UUG": "Leucine",
	"UCU": "Serine",
	"UCC": "Serine",
	"UCA": "Serine",
	"UCG": "Serine",
	"UAU": "Tyrosine",
	"UAC": "Tyrosine",
	"UGU": "Cysteine",
	"UGC": "Cysteine",
	"UGG": "Tryptophan",
	"UAA": "STOP",
	"UAG": "STOP",
	"UGA": "STOP",
}

func FromRNA(seq string) ([]string, error) {
	var proteins []string
	for len(seq) >= 3 {
		val, err := FromCodon(seq[:3])
		if err == ErrStop {
			break
		}
		if err != nil {
			return nil, err
		}
		proteins = append(proteins, val)
		seq = seq[3:]
	}
	return proteins, nil
}

func FromCodon(c string) (string, error) {
	val, ok := codonMap[c]
	if !ok {
		return "", ErrInvalidBase
	}
	if val == "STOP" {
		return "", ErrStop
	}
	return val, nil
}
