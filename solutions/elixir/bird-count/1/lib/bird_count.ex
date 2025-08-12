defmodule BirdCount do
  def today([]), do: nil
  def today([head | _tail]), do: head

  def increment_day_count([]), do: [1]
  def increment_day_count([h | t]), do: [h + 1 | t]

  def has_day_without_birds?(list), do: 0 in list

  def total(list), do: total(0, list)
  defp total(count, []), do: count
  defp total(count, [h | t]), do: total(count + h, t)

  def busy_days(list), do: busy_days(0, list)
  defp busy_days(count, []), do: count
  defp busy_days(count, [h | t]) when h >= 5, do: busy_days(count + 1, t)
  defp busy_days(count, [_h | t]), do: busy_days(count, t)
end