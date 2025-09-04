// Shree DR.MDD
package clock
import "fmt"
const (
	hourToMin = 60
	dayToMin  = 24 * hourToMin
)
type Clock struct {
	totalMin int
}
func New(h, m int) Clock {
	val := (h*hourToMin + m) % dayToMin
	if val < 0 {
		val += dayToMin
	}
	return Clock{val}
}
func (c Clock) Add(m int) Clock {
	return New(0, c.totalMin+m)
}
func (c Clock) Subtract(m int) Clock {
	return New(0, c.totalMin-m)
}
func (c Clock) String() string {
	return fmt.Sprintf("%02d:%02d", c.totalMin/hourToMin, c.totalMin%hourToMin)
}
