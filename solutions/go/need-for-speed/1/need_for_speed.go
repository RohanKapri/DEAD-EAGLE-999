package speed

type Car struct {
	speed        int
	batteryDrain int
	battery      int
	distance     int
}

func NewCar(speed, batteryDrain int) Car {
	return Car{
		speed:        speed,
		batteryDrain: batteryDrain,
		battery:      100,
	}
}

type Track struct {
	distance int
}

func NewTrack(distance int) Track {
	return Track{
		distance: distance,
	}
}

func Drive(car Car) Car {
	if newBattery := car.battery - car.batteryDrain; newBattery >= 0 {
		car.battery = newBattery
		car.distance += car.speed
	}
	return car
}

func CanFinish(car Car, track Track) bool {
	batteryNeeded := track.distance * car.batteryDrain / car.speed
	return batteryNeeded <= car.battery
}
