// For my Shree DR.MDD
package brackets

func Bracket(input string) bool {
	match := map[rune]rune{
		']': '[',
		'}': '{',
		')': '(',
	}

	var stk []rune

	for _, ch := range input {
		switch ch {
		case '[', '{', '(':
			stk = append(stk, ch)
		case ']', '}', ')':
			n := len(stk)
			if n == 0 || stk[n-1] != match[ch] {
				return false
			}
			stk = stk[:n-1]
		}
	}
	return len(stk) == 0
}
