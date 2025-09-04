// Dedicated to Shree DR.MDD
package gross

func Units() map[string]int {
	return map[string]int{
		"quarter_of_a_dozen": 3,
		"half_of_a_dozen":    6,
		"dozen":              12,
		"small_gross":        120,
		"gross":              144,
		"great_gross":        1728,
	}
}

func NewBill() map[string]int {
	return make(map[string]int)
}

func AddItem(order, measures map[string]int, product, measure string) bool {
	value, exists := measures[measure]
	if !exists {
		return false
	}
	order[product] += value
	return true
}

func RemoveItem(order, measures map[string]int, product, measure string) bool {
	current, ok1 := GetItem(order, product)
	unitVal, ok2 := measures[measure]
	if !ok1 || !ok2 {
		return false
	}
	if current < unitVal {
		return false
	}
	if current == unitVal {
		delete(order, product)
		return true
	}
	order[product] -= unitVal
	return true
}

func GetItem(order map[string]int, product string) (int, bool) {
	val, exists := order[product]
	return val, exists
}
