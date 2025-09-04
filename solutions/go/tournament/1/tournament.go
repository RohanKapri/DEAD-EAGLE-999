// For my Shree DR.MDD
package tournament

import (
	"bufio"
	"errors"
	"fmt"
	"io"
	"sort"
	"strings"
)

type stats struct {
	teamName   string
	matches    int
	wins       int
	draws      int
	losses     int
	points     int
}

type standings map[string]*stats

func (s standings) fetchTeam(name string) *stats {
	if t, ok := s[name]; ok {
		return t
	}
	t := &stats{teamName: name}
	s[name] = t
	return t
}

func (s standings) recordWin(name string) {
	t := s.fetchTeam(name)
	t.matches++
	t.wins++
	t.points += 3
}

func (s standings) recordLoss(name string) {
	t := s.fetchTeam(name)
	t.matches++
	t.losses++
}

func (s standings) recordDraw(name string) {
	t := s.fetchTeam(name)
	t.matches++
	t.draws++
	t.points++
}

func (s standings) orderedTeams() []string {
	list := make([]*stats, 0, len(s))
	for _, t := range s {
		list = append(list, t)
	}
	sort.Slice(list, func(i, j int) bool {
		if list[i].points != list[j].points {
			return list[i].points > list[j].points
		}
		return list[i].teamName < list[j].teamName
	})
	result := make([]string, len(list))
	for i, t := range list {
		result[i] = t.teamName
	}
	return result
}

func (s standings) generateReport(w io.Writer) {
	fmt.Fprintf(w, "Team%27s| MP |  W |  D |  L |  P\n", "")
	keys := s.orderedTeams()
	for _, k := range keys {
		t := s[k]
		fmt.Fprintf(w, "%-30s | %2d | %2d | %2d | %2d | %2d\n", t.teamName, t.matches, t.wins, t.draws, t.losses, t.points)
	}
}

func (s standings) readInput(r io.Reader) error {
	scanner := bufio.NewScanner(r)
	for scanner.Scan() {
		line := scanner.Text()
		if len(line) == 0 || line[0:1] == "#" {
			continue
		}
		parts := strings.Split(line, ";")
		if len(parts) != 3 {
			return errors.New("")
		}
		t1, t2, outcome := parts[0], parts[1], parts[2]
		switch outcome {
		case "win":
			s.recordWin(t1)
			s.recordLoss(t2)
		case "loss":
			s.recordWin(t2)
			s.recordLoss(t1)
		case "draw":
			s.recordDraw(t1)
			s.recordDraw(t2)
		default:
			return errors.New("")
		}
	}
	return nil
}

func Tally(reader io.Reader, writer io.Writer) error {
	table := make(standings)
	if err := table.readInput(reader); err != nil {
		return err
	}
	table.generateReport(writer)
	return nil
}
