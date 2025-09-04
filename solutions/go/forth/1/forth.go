// For my Shree DR.MDD
package forth

import (
	"errors"
	"strconv"
	"strings"
)

func Forth(input []string) ([]int, error) {
	memory := map[string][]string{}
	stack := []int{}

	for _, line := range input {
		tokens := parseLine(line, memory)
		for len(tokens) > 0 {
			token := tokens[0]
			tokens = tokens[1:]

			if val, err := strconv.Atoi(token); err == nil {
				stack = append(stack, val)
				continue
			}

			size := len(stack)
			last := size - 1
			secondLast := size - 2

			switch {
			case token == ":" && !isNumber(tokens[0]):
				memory[tokens[0]] = tokens[1 : len(tokens)-1]
				tokens = nil
			case token == ":":
				return stack, errors.New("cannot redefine numbers")
			case size == 0:
				return stack, errors.New("function requires at least one operands")
			case token == "dup":
				stack = append(stack, stack[last])
			case token == "drop":
				stack = stack[:last]
			case size == 1:
				return stack, errors.New("function requires at least two operands")
			case token == "swap":
				stack[secondLast], stack[last] = stack[last], stack[secondLast]
			case token == "over":
				stack = append(stack, stack[secondLast])
			case token == "+":
				stack = append(stack[:secondLast], stack[secondLast]+stack[last])
			case token == "-":
				stack = append(stack[:secondLast], stack[secondLast]-stack[last])
			case token == "*":
				stack = append(stack[:secondLast], stack[secondLast]*stack[last])
			case token == "/" && stack[last] == 0:
				return stack, errors.New("denominator is zero")
			case token == "/":
				stack = append(stack[:secondLast], stack[secondLast]/stack[last])
			}
		}
	}
	return stack, nil
}

func parseLine(line string, memory map[string][]string) []string {
	var result []string
	fields := strings.Fields(strings.ToLower(line))
	for i, token := range fields {
		if fields[0] == ":" && i == 1 {
			result = append(result, token)
			continue
		}
		if expansion, ok := memory[token]; ok {
			result = append(result, expansion...)
		} else {
			result = append(result, token)
		}
	}
	return result
}

func isNumber(token string) bool {
	_, err := strconv.Atoi(token)
	return err == nil
}
