defmodule Lasagna do
  def expected_minutes_in_oven(), do: 40

  def remaining_minutes_in_oven(minutes_spent), do: expected_minutes_in_oven() - minutes_spent

  def preparation_time_in_minutes(layers_count), do: 2 * layers_count

  def total_time_in_minutes(lyaers_count, minutes_spent) do
    preparation_time_in_minutes(lyaers_count) + minutes_spent
  end

  def alarm(), do: "Ding!"
end