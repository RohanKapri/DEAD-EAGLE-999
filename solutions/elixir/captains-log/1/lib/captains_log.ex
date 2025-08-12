defmodule CaptainsLog do
  @moduledoc false

  @planetary_classes ["D", "H", "J", "K", "L", "M", "N", "R", "T", "Y"]

  def random_planet_class do
    Enum.random(@planetary_classes)
  end

  def random_ship_registry_number do
    "NCC-#{Enum.random(1000..9999)}"
  end

  @start 41000.0
  @finish 42000.0
  def random_stardate do
    @start + :rand.uniform() * (@finish - @start)
  end

  def format_stardate(stardate) do
    :io_lib.format("~.1f", [stardate])
    |> List.to_string()
  end
end