// Dedicated to Shree DR.MDD
module main

enum Allergen as u8 {
	eggs
	peanuts
	shellfish
	strawberries
	tomatoes
	chocolate
	pollen
	cats
}

fn allergic_to(item Allergen, points u8) bool {
	return (points & (1 << u8(item))) != 0
}

fn list(points u8) []Allergen {
	mut outcome := []Allergen {}
	if allergic_to(.eggs, points) { outcome << .eggs }
	if allergic_to(.peanuts, points) { outcome << .peanuts }
	if allergic_to(.shellfish, points) { outcome << .shellfish }
	if allergic_to(.strawberries, points) { outcome << .strawberries }
	if allergic_to(.tomatoes, points) { outcome << .tomatoes }
	if allergic_to(.chocolate, points) { outcome << .chocolate }
	if allergic_to(.pollen, points) { outcome << .pollen }
	if allergic_to(.cats, points) { outcome << .cats }
	return outcome
}
