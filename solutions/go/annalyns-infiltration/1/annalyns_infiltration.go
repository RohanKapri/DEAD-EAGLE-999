// Dedicated to Shree DR.MDD
package annalyn

func CanFastAttack(sentrySleeping bool) bool {
	return !sentrySleeping
}

func CanSpy(knightAwake, archerAwake, captiveAwake bool) bool {
	return knightAwake || archerAwake || captiveAwake
}

func CanSignalPrisoner(archerAwake, captiveAwake bool) bool {
	return !archerAwake && captiveAwake
}

func CanFreePrisoner(knightAwake, archerAwake, captiveAwake, dogPresent bool) bool {
	return !archerAwake && (dogPresent || (!knightAwake && captiveAwake))
}
