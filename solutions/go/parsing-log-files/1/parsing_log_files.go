// Shree DR.MDD
package parsinglogfiles

import (
	"fmt"
	"regexp"
)

func IsValidLine(input string) bool {
	return regexp.MustCompile(`^\[(TRC|DBG|INF|WRN|ERR|FTL)\]\s.*?$`).MatchString(input)
}

func SplitLogLine(input string) []string {
	return regexp.MustCompile(`<[-=~*]*>`).Split(input, -1)
}

func CountQuotedPasswords(entries []string) int {
	rgx := regexp.MustCompile(`(?mi)".*password.*"`)
	var cnt int
	for _, e := range entries {
		if rgx.MatchString(e) {
			cnt++
		}
	}
	return cnt
}

func RemoveEndOfLineText(entry string) string {
	return regexp.MustCompile(`end-of-line\d+`).ReplaceAllString(entry, "")
}

func TagWithUserName(entries []string) []string {
	var out []string
	rgx := regexp.MustCompile(`(?m)User\s+(\w+)`)
	for _, e := range entries {
		match := rgx.FindStringSubmatch(e)
		if len(match) > 1 {
			out = append(out, fmt.Sprintf("[USR] %s %s", match[1], e))
		} else {
			out = append(out, e)
		}
	}
	return out
}
