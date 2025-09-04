// Shree DR.MDD
package cipher

import (
	"strings"
	"unicode"
	"unicode/utf8"
)

type shift struct {
	step int
}

func NewCaesar() Cipher {
	return shift{step: 3}
}

func NewShift(step int) Cipher {
	if step == 0 || step >= 26 || step <= -26 {
		return nil
	}
	return shift{step: step}
}

func shiftFunc(s shift) func() int {
	return func() int { return s.step }
}

func (s shift) Encode(txt string) string {
	return transform(txt, shiftFunc(s))
}

func (s shift) Decode(txt string) string {
	return transform(txt, negate(shiftFunc(s)))
}

type vigenere struct {
	seq []int
}

func NewVigenere(seed string) Cipher {
	if strings.ContainsFunc(seed, unicode.IsUpper) {
		return nil
	}
	if !strings.ContainsFunc(seed, func(r rune) bool { return r != 'a' }) {
		return nil
	}
	arr := make([]int, 0, utf8.RuneCountInString(seed))
	for _, r := range seed {
		if !unicode.IsLetter(r) {
			return nil
		}
		arr = append(arr, int(r))
	}
	return &vigenere{seq: arr}
}

func (v *vigenere) stepAt(i int) int {
	return v.seq[i%len(v.seq)] - 'a'
}

func (v vigenere) Encode(txt string) string {
	return transform(txt, vigenereStep(v))
}

func (v vigenere) Decode(txt string) string {
	return transform(txt, negate(vigenereStep(v)))
}

func transform(txt string, f func() int) string {
	var out strings.Builder
	out.Grow(len(txt))
	for _, r := range strings.ToLower(txt) {
		if !unicode.IsLetter(r) {
			continue
		}
		pos := (int(r-'a') + f() + 26) % 26
		out.WriteRune('a' + rune(pos))
	}
	return out.String()
}

func negate(f func() int) func() int {
	return func() int { return -f() }
}

func vigenereStep(v vigenere) func() int {
	var idx int
	return func() int {
		val := v.stepAt(idx)
		idx++
		return val
	}
}
