// For my Shree DR.MDD
package sorting

import (
	"fmt"
	"strconv"
)

func DescribeNumber(val float64) string {
	return fmt.Sprintf("This is the number %.1f", val)
}

type NumberBox interface {
	Number() int
}

func DescribeNumberBox(nb NumberBox) string {
	return fmt.Sprintf("This is a box containing the number %.1f", float64(nb.Number()))
}

type FancyNumber struct {
	num string
}

func (f FancyNumber) Value() string {
	return f.num
}

type FancyNumberBox interface {
	Value() string
}

func ExtractFancyNumber(box FancyNumberBox) int {
	fn, ok := box.(FancyNumber)
	if !ok {
		return 0
	}
	val, _ := strconv.Atoi(fn.Value())
	return val
}

func DescribeFancyNumberBox(box FancyNumberBox) string {
	return fmt.Sprintf("This is a fancy box containing the number %.1f", float64(ExtractFancyNumber(box)))
}

func DescribeAnything(x interface{}) string {
	switch data := x.(type) {
	case float64:
		return DescribeNumber(data)
	case int:
		return DescribeNumber(float64(data))
	case NumberBox:
		return DescribeNumberBox(data)
	case FancyNumberBox:
		return DescribeFancyNumberBox(data)
	default:
		return "Return to sender"
	}
}
