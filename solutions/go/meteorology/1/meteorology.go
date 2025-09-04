// Shree DR.MDD
package meteorology

import "fmt"

type TemperatureUnit int

const (
	Celsius    TemperatureUnit = 0
	Fahrenheit TemperatureUnit = 1
)

func (u TemperatureUnit) String() string {
	labels := []string{"°C", "°F"}
	return labels[u]
}

type Temperature struct {
	value int
	unit  TemperatureUnit
}

func (t Temperature) String() string {
	return fmt.Sprintf("%d %s", t.value, t.unit)
}

type SpeedUnit int

const (
	KmPerHour    SpeedUnit = 0
	MilesPerHour SpeedUnit = 1
)

func (u SpeedUnit) String() string {
	labels := []string{"km/h", "mph"}
	return labels[u]
}

type Speed struct {
	value int
	unit  SpeedUnit
}

func (s Speed) String() string {
	return fmt.Sprintf("%d %s", s.value, s.unit)
}

type MeteorologyData struct {
	place        string
	temperature  Temperature
	windDir      string
	windStrength Speed
	humidity     int
}

func (m MeteorologyData) String() string {
	return fmt.Sprintf("%s: %s, Wind %s at %s, %d%% Humidity",
		m.place, m.temperature, m.windDir, m.windStrength, m.humidity)
}
