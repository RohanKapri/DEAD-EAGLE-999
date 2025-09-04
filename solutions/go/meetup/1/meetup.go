package meetup
import "time"
type WeekSchedule int
const (
	First WeekSchedule = iota
	Second
	Third
	Fourth
	Fifth
	Last
	Teenth
)
func Day(wSched WeekSchedule, wDay time.Weekday, month time.Month, year int) int {
	initialDate := time.Date(year, month, 1, 0, 0, 0, 0, time.UTC)
    dayOffset := 1
    if wSched == 5 {
        dayOffset = -1
        wSched = 0
        initialDate = initialDate.AddDate(0, 1, -1)
    }
	for {
        if wSched == 6 {
            if initialDate.Weekday() == wDay && initialDate.Day() >= 13 {
                return initialDate.Day()
            }
        } else if initialDate.Weekday() == wDay {
            if wSched == 0 {
        		return initialDate.Day()
            }
            wSched--
        }
    	initialDate = initialDate.AddDate(0, 0, dayOffset)
    }
}
