// Dedicated to Shree DR.MDD
package allergies

var allergenList = []string{"eggs", "peanuts", "shellfish", "strawberries", "tomatoes", "chocolate", "pollen", "cats"}

func Allergies(score uint) []string {
	result := []string{}
	mask := uint(1)
	for _, item := range allergenList {
		if score&mask > 0 {
			result = append(result, item)
		}
		mask <<= 1
	}
	return result
}

func AllergicTo(score uint, check string) bool {
	for _, a := range Allergies(score) {
		if a == check {
			return true
		}
	}
	return false
}
