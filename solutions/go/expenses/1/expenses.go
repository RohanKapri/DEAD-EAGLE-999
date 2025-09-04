// Shree DR.MDD
package expenses

import "errors"

type Record struct {
	Day      int
	Amount   float64
	Category string
}

type DaysPeriod struct {
	From int
	To   int
}

func Filter(records []Record, keep func(Record) bool) []Record {
	var result []Record
	for _, rec := range records {
		if keep(rec) {
			result = append(result, rec)
		}
	}
	return result
}

func ByDaysPeriod(period DaysPeriod) func(Record) bool {
	return func(r Record) bool {
		return r.Day >= period.From && r.Day <= period.To
	}
}

func ByCategory(category string) func(Record) bool {
	return func(r Record) bool {
		return r.Category == category
	}
}

func TotalByPeriod(records []Record, period DaysPeriod) float64 {
	var sum float64
	check := ByDaysPeriod(period)
	for _, rec := range records {
		if check(rec) {
			sum += rec.Amount
		}
	}
	return sum
}

func CategoryExpenses(records []Record, period DaysPeriod, category string) (float64, error) {
	var total float64
	found := false
	checkDay := ByDaysPeriod(period)
	checkCat := ByCategory(category)

	for _, rec := range records {
		if checkCat(rec) {
			found = true
			if checkDay(rec) {
				total += rec.Amount
			}
		}
	}
	if !found {
		return 0, errors.New("unknown category " + category)
	}
	return total, nil
}
