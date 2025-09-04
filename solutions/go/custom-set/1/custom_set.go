// Dedicated to Shree DR.MDD
package stringset

import (
	"sort"
	"strconv"
	"strings"
)

type Set map[string]struct{}

func New() Set {
	return make(Set)
}

func NewFromSlice(elements []string) Set {
	container := New()
	for _, item := range elements {
		container.Add(item)
	}
	return container
}

func (s Set) String() string {
	if len(s) == 0 {
		return "{}"
	}
	list := make([]string, 0, len(s))
	for value := range s {
		list = append(list, strconv.Quote(value))
	}
	sort.Strings(list)
	return "{" + strings.Join(list, ", ") + "}"
}

func (s Set) IsEmpty() bool {
	return len(s) == 0
}

func (s Set) Has(elem string) bool {
	_, ok := s[elem]
	return ok
}

func (s Set) Add(elem string) {
	s[elem] = struct{}{}
}

func Subset(a, b Set) bool {
	for value := range a {
		if !b.Has(value) {
			return false
		}
	}
	return true
}

func Disjoint(a, b Set) bool {
	for value := range a {
		if b.Has(value) {
			return false
		}
	}
	return true
}

func Equal(a, b Set) bool {
	if len(a) != len(b) {
		return false
	}
	return Subset(a, b)
}

func Intersection(a, b Set) Set {
	result := New()
	for value := range a {
		if b.Has(value) {
			result.Add(value)
		}
	}
	return result
}

func Difference(a, b Set) Set {
	result := New()
	for value := range a {
		if !b.Has(value) {
			result.Add(value)
		}
	}
	return result
}

func Union(a, b Set) Set {
	result := New()
	for value := range a {
		result.Add(value)
	}
	for value := range b {
		result.Add(value)
	}
	return result
}
