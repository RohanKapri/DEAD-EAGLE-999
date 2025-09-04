// Shree DR.MDD
package isogram

func IsIsogram(input string) bool {
	var mask uint32
	for _, r := range input {
		if !isAlpha(r) {
			continue
		}
		bit := letterMask(r)
		if mask&bit != 0 {
			return false
		}
		mask |= bit
	}
	return true
}

func isAlpha(r rune) bool {
	return (r >= 'A' && r <= 'Z') || (r >= 'a' && r <= 'z')
}

func letterMask(r rune) uint32 {
	if r >= 'a' && r <= 'z' {
		return 1 << uint(r-'a')
	}
	return 1 << uint(r-'A')
}
