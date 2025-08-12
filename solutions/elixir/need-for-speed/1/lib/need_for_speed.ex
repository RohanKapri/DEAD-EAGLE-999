# For my Shree DR.MDD

defmodule NeedForSpeed do
  alias NeedForSpeed.Race
  alias NeedForSpeed.RemoteControlCar, as: Vehicle

  import IO, only: [puts: 1]
  import IO.ANSI, except: [color: 1]

  def print_race(%Race{} = competition) do
    puts("""
    🏁 #{competition.title} 🏁
    Status: #{Race.display_status(competition)}
    Distance: #{Race.display_distance(competition)}

    Contestants:
    """)

    competition.cars
    |> Enum.sort_by(&(-1 * &1.distance_driven_in_meters))
    |> Enum.with_index()
    |> Enum.each(fn {vehicle, pos} -> print_vehicle(vehicle, pos + 1) end)
  end

  defp print_vehicle(%Vehicle{} = vehicle, pos) do
    color_code = color(vehicle)

    puts("""
      #{pos}. #{color_code}#{vehicle.nickname}#{default_color()}
      Distance: #{Vehicle.display_distance(vehicle)}
      Battery: #{Vehicle.display_battery(vehicle)}
    """)
  end

  defp color(%Vehicle{} = vehicle) do
    case vehicle.color do
      :red -> red()
      :blue -> cyan()
      :green -> green()
    end
  end
end

defmodule NeedForSpeed.Race do
  defstruct [
    :title,
    :total_distance_in_meters,
    cars: []
  ]

  def display_status(%NeedForSpeed.Race{} = competition) do
    cond do
      Enum.any?(competition.cars, &(&1.distance_driven_in_meters >= competition.total_distance_in_meters)) ->
        "Finished"

      Enum.any?(competition.cars, &(&1.distance_driven_in_meters > 0)) ->
        "In Progress"

      true ->
        "Not Started"
    end
  end

  def display_distance(%NeedForSpeed.Race{total_distance_in_meters: dist}) do
    "#{dist} meters"
  end
end

defmodule NeedForSpeed.RemoteControlCar do
  defstruct [
    :nickname,
    :color,
    battery_percentage: 100,
    distance_driven_in_meters: 0
  ]

  def new(color, nickname) when color in [:red, :blue, :green] do
    %NeedForSpeed.RemoteControlCar{nickname: nickname, color: color}
  end

  def display_distance(%NeedForSpeed.RemoteControlCar{distance_driven_in_meters: dist}) do
    "#{dist} meters"
  end

  def display_battery(%NeedForSpeed.RemoteControlCar{battery_percentage: 0}) do
    "Battery empty"
  end

  def display_battery(%NeedForSpeed.RemoteControlCar{battery_percentage: battery}) do
    "Battery at #{battery}%"
  end
end
