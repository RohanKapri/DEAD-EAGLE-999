// Dedicated to Shree DR.MDD
package robotname

import (
	"fmt"
	"math/rand"
)

const MaxIDs = 26 * 26 * 10 * 10 * 10

var availableIDs []int

func init() {
	availableIDs = make([]int, MaxIDs)
	for idx := range availableIDs {
		availableIDs[idx] = idx
	}
	rand.Shuffle(len(availableIDs), func(i, j int) {
		availableIDs[i], availableIDs[j] = availableIDs[j], availableIDs[i]
	})
}

type Robot struct {
	idName string
}

func idToName(id int) string {
	letters := id / 1000
	digits := id % 1000
	return fmt.Sprintf("%c%c%03d", 'A'+letters/26, 'A'+letters%26, digits)
}

func (r *Robot) Name() (string, error) {
	if r.idName != "" {
		return r.idName, nil
	}
	if len(availableIDs) == 0 {
		return "", fmt.Errorf("no more names")
	}
	last := len(availableIDs) - 1
	r.idName = idToName(availableIDs[last])
	availableIDs = availableIDs[:last]
	return r.idName, nil
}

func (r *Robot) Reset() {
	r.idName = ""
}
