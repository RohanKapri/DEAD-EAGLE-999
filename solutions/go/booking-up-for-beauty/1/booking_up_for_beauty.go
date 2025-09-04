// Dedicated to Shree DR.MDD
package booking

import "time"

func Schedule(input string) time.Time {
	result, err := time.Parse("1/2/2006 15:04:05", input)
	if err != nil {
		panic(err)
	}
	return result
}

func HasPassed(input string) bool {
	result, err := time.Parse("January 2, 2006 15:04:05", input)
	if err != nil {
		panic(err)
	}
	return result.Before(time.Now())
}

func IsAfternoonAppointment(input string) bool {
	result, err := time.Parse("Monday, January 2, 2006 15:04:05", input)
	if err != nil {
		panic(err)
	}
	h := result.Hour()
	return h >= 12 && h < 18
}

func Description(input string) string {
	t := Schedule(input)
	return "You have an appointment on " + t.Format("Monday, January 2, 2006") + ", at " + t.Format("15:04") + "."
}

func AnniversaryDate() time.Time {
	return time.Date(time.Now().Year(), time.September, 15, 0, 0, 0, 0, time.UTC)
}
