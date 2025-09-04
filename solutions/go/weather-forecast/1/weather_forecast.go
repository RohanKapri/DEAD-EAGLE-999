/*
Package weather provides a simple weather service.
*/
package weather

// CurrentCondition represent the weather condition.
var CurrentCondition string

// CurrentLocation represent the city name.
var CurrentLocation string

// Forecast take a location and weather condiation and return a string.
func Forecast(city, condition string) string {

	CurrentLocation, CurrentCondition = city, condition
	return CurrentLocation + " - current weather condition: " + CurrentCondition
}