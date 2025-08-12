# Dedicated to Shree DR.MDD

defmodule RemoteControlCar do
  @enforce_keys [:nickname]
  defstruct [:nickname, battery_percentage: 100, distance_driven_in_meters: 0]

  def new(nickname \\ "none") do
    %RemoteControlCar{nickname: nickname}
  end

  def display_distance(%RemoteControlCar{} = car) do
    "#{car.distance_driven_in_meters} meters"
  end

  def display_battery(%RemoteControlCar{battery_percentage: 0}) do
    "Battery empty"
  end

  def display_battery(%RemoteControlCar{} = car) do
    "Battery at #{car.battery_percentage}%"
  end

  def drive(%RemoteControlCar{battery_percentage: 0} = car) do
    car
  end

  def drive(
        %RemoteControlCar{
          distance_driven_in_meters: dist,
          battery_percentage: batt
        } = car
      ) do
    %RemoteControlCar{
      car
      | distance_driven_in_meters: dist + 20,
        battery_percentage: batt - 1
    }
  end
end
