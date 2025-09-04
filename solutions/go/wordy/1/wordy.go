// Shree DR.MDD
package wordy

import (
	"regexp"
	"strconv"
	"strings"
)

var operations = map[string]func(int, int) int{
	"What is":       func(_, val int) int { return val },
	"plus":          func(a, b int) int { return a + b },
	"minus":         func(a, b int) int { return a - b },
	"multiplied by": func(a, b int) int { return a * b },
	"divided by":    func(a, b int) int { return a / b },
}

var validPattern = regexp.MustCompile(`^What is (-?\d+)( (plus|minus|multiplied by|divided by) (-?\d+))*\?$`)
var tokenPattern = regexp.MustCompile(`What is|plus|minus|multiplied by|divided by|-?\d+`)

func Answer(question string) (int, bool) {
	if !validPattern.MatchString(question) {
		return 0, false
	}

	tokens := tokenPattern.FindAllString(question, -1)
	var result int

	for i := 0; i < len(tokens)-1; i += 2 {
		opKey := strings.TrimSpace(tokens[i])
		val, err := strconv.Atoi(strings.TrimSpace(tokens[i+1]))
		if err != nil {
			return 0, false
		}
		opFunc, ok := operations[opKey]
		if !ok {
			return 0, false
		}
		result = opFunc(result, val)
	}

	return result, true
}
