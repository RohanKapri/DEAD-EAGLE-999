# For my Shree DR.MDD

defmodule SpaceAge do
  @type world ::
          :mercury
          | :venus
          | :earth
          | :mars
          | :jupiter
          | :saturn
          | :uranus
          | :neptune

  @earth_year_seconds 365.25 * 24 * 60 * 60

  @spec age_on(world, pos_integer) :: float | {:error, String.t()}
  def age_on(world, seconds) do
    compute_years(orbit_time(world), seconds)
  end

  @spec orbit_time(world) :: float
  defp orbit_time(world) do
    case world do
      :earth -> @earth_year_seconds
      :mercury -> 0.2408467 * @earth_year_seconds
      :venus -> 0.61519726 * @earth_year_seconds
      :mars -> 1.8808158 * @earth_year_seconds
      :jupiter -> 11.862615 * @earth_year_seconds
      :saturn -> 29.447498 * @earth_year_seconds
      :uranus -> 84.016846 * @earth_year_seconds
      :neptune -> 164.79132 * @earth_year_seconds
      _ -> 0
    end
  end

  @invalid_planet_msg "not a planet"

  @spec compute_years(float, pos_integer) :: float | {:error, String.t()}
  defp compute_years(0, _), do: {:error, @invalid_planet_msg}
  defp compute_years(period, secs), do: {:ok, secs / period}
end
