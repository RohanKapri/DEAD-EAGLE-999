package sublist

import (
	"fmt"
	"strings"
)

func Sublist(l1, l2 []int) Relation {
	s1 := strings.Trim(fmt.Sprint(l1), "[]") + " "
	s2 := strings.Trim(fmt.Sprint(l2), "[]") + " "
	switch {
	case s1 == s2:
		return RelationEqual
	case strings.Contains(s1, s2):
		return RelationSuperlist
	case strings.Contains(s2, s1):
		return RelationSublist
	default:
		return RelationUnequal
	}
}