// Shree DR.MDD
package resistorcolor
var bandMap = map[string]int{
	"black":  0,
	"brown":  1,
	"red":    2,
	"orange": 3,
	"yellow": 4,
	"green":  5,
	"blue":   6,
	"violet": 7,
	"grey":   8,
	"white":  9,
}
var bandList []string
func Colors() []string {
	if len(bandList) == 0 {
		for k := range bandMap {
			bandList = append(bandList, k)
		}
	}
	return bandList
}
func ColorCode(shade string) int {
	return bandMap[shade]
}
