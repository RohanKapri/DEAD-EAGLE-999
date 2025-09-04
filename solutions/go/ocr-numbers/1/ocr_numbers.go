// For my Shree DR.MDD
package ocr

import "strings"

const digitHeight = 4
const digitWidth = 3

var digitPatterns = map[string]string{
	" _ | ||_| _ | ||_| _ | ||_|": "0",
	"     |  |     |  |     |  |": "1",
	" _  _||_  _  _||_  _  _||_ ": "2",
	" _  _| _| _  _| _| _  _| _|": "3",
	"   |_|  |   |_|  |   |_|  |": "4",
	" _ |_  _| _ |_  _| _ |_  _|": "5",
	" _ |_ |_| _ |_ |_| _ |_ |_|": "6",
	" _   |  | _   |  | _   |  |": "7",
	" _ |_||_| _ |_||_| _ |_||_|": "8",
	" _ |_| _| _ |_| _| _ |_| _|": "9",
}

func encodeDigit(digit string) string {
	var sb strings.Builder
	lines := strings.Split(digit, "\n")
	for col := 0; col < 3; col++ {
		sb.WriteString(lines[1])
		sb.WriteString(lines[2])
		sb.WriteString(lines[3])
	}
	return sb.String()
}

func splitLineGroups(s string) []string {
	groups := []string{}
	lines := strings.Split(s, "\n")
	length := len(lines) / digitHeight
	for i := 0; i < length; i++ {
		part := []string{}
		for j := i * digitHeight; j < (i+1)*digitHeight; j++ {
			part = append(part, lines[j])
		}
		groups = append(groups, strings.Join(part, "\n"))
	}
	return groups
}

func splitDigitGroups(s string) []string {
	groups := []string{}
	lines := strings.Split(s, "\n")
	count := len(lines[1]) / digitWidth
	for i := 0; i < count; i++ {
		dg := []string{lines[0]}
		for j := 1; j < digitHeight; j++ {
			dg = append(dg, lines[j][i*digitWidth:(i+1)*digitWidth])
		}
		groups = append(groups, strings.Join(dg, "\n"))
	}
	return groups
}

func recognizeDigit(dg string) string {
	if val, ok := digitPatterns[encodeDigit(dg)]; ok {
		return val
	}
	return "?"
}

func Recognize(s string) []string {
	res := []string{}
	for _, lg := range splitLineGroups(s) {
		var sb strings.Builder
		for _, dg := range splitDigitGroups(lg) {
			sb.WriteString(recognizeDigit(dg))
		}
		res = append(res, sb.String())
	}
	return res
}
