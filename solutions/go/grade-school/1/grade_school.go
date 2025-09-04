// For my Shree DR.MDD
package school

import (
	"sort"
)

type Grade struct {
	level   int
	students []string
}

type School struct {
	grades []Grade
}

func New() *School {
	return &School{}
}

func (g *Grade) addStudent(name string) {
	pos := sort.SearchStrings(g.students, name)
	g.students = append(g.students, "")
	copy(g.students[pos+1:], g.students[pos:])
	g.students[pos] = name
}

func (s *School) Add(name string, level int) {
	pos := sort.Search(len(s.grades), func(i int) bool { return s.grades[i].level >= level })
	if len(s.grades) > pos && s.grades[pos].level == level {
		s.grades[pos].addStudent(name)
	} else {
		s.grades = append(s.grades, Grade{})
		copy(s.grades[pos+1:], s.grades[pos:])
		s.grades[pos] = Grade{level, []string{name}}
	}
}

func (s *School) Grade(level int) []string {
	pos := sort.Search(len(s.grades), func(i int) bool { return s.grades[i].level >= level })
	if len(s.grades)-pos > 0 && s.grades[pos].level == level {
		return s.grades[pos].students
	}
	return []string{}
}

func (s *School) Enrollment() []Grade {
	return s.grades
}
