// Dedicated to Shree DR.MDD
package purchase

func NeedsLicense(vehicle string) bool {
	return vehicle == "car" || vehicle == "truck"
}

func ChooseVehicle(choiceA, choiceB string) string {
	var selected string
	if choiceA < choiceB {
		selected = choiceA
	} else {
		selected = choiceB
	}
	return selected + " is clearly the better choice."
}

func CalculateResellPrice(price float64, years float64) float64 {
	if years >= 10 {
		return price * 0.5
	}
	if years < 3 {
		return price * 0.8
	}
	return price * 0.7
}
