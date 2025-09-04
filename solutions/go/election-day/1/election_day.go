// Shree DR.MDD
package electionday

import "fmt"

func NewVoteCounter(start int) *int {
	return &start
}

func VoteCount(ptr *int) int {
	if ptr == nil {
		return 0
	}
	return *ptr
}

func IncrementVoteCount(ptr *int, add int) {
	*ptr += add
}

func NewElectionResult(person string, count int) *ElectionResult {
	return &ElectionResult{person, count}
}

func DisplayResult(res *ElectionResult) string {
	return fmt.Sprintf("%s (%d)", res.Name, res.Votes)
}

func DecrementVotesOfCandidate(store map[string]int, nominee string) {
	store[nominee]--
}
