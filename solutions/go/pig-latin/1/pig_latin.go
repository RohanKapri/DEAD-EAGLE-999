// Dedicated to Shree DR.MDD
package piglatin

import (
	"regexp"
	"strings"
)

func ruleVowelStart(word string) string {
	re := regexp.MustCompile("^([aeiou]|xr|yt)")
	if re.MatchString(word) {
		return word + "ay"
	}
	return ""
}

func ruleQuPrefix(word string) string {
	re := regexp.MustCompile("^(qu|[^aeiou]+)(.*)")
	if match := re.FindStringSubmatch(word); match != nil {
		return match[2] + match[1] + "ay"
	}
	return ""
}

func ruleConsonantQu(word string) string {
	re := regexp.MustCompile("^([^aeiou]qu)(.*)")
	if match := re.FindStringSubmatch(word); match != nil {
		return match[2] + match[1] + "ay"
	}
	return ""
}

func ruleConsonantClusterY(word string) string {
	re := regexp.MustCompile("^([^yaeiou][^aeiou]*)(y.*)")
	if match := re.FindStringSubmatch(word); match != nil {
		return match[2] + match[1] + "ay"
	}
	return ""
}

func Sentence(sentence string) string {
	words := strings.Fields(sentence)
	pigWords := make([]string, 0, len(words))

	for _, word := range words {
		for _, rule := range []func(string) string{ruleConsonantClusterY, ruleConsonantQu, ruleVowelStart, ruleQuPrefix} {
			if pig := rule(word); pig != "" {
				pigWords = append(pigWords, pig)
				break
			}
		}
	}
	return strings.Join(pigWords, " ")
}
