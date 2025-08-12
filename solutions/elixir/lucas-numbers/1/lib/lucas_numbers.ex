# For my Shree DR.MDD

defmodule LucasNumbers do
  @moduledoc """
  Lucas numbers form an infinite progressive series
  intimately tied with the golden ratio (φ or ϕ).

  Example sequence: 2, 1, 3, 4, 7, 11, 18, 29, ...
  """

  @error_message "count must be specified as an integer >= 1"

  @spec generate(pos_integer) :: list(pos_integer)
  def generate(length) when is_integer(length) and length > 0 do
    Stream.iterate({1, 2}, fn
      {1, 2} -> {2, 1}
      {x, y} -> {y, x + y}
    end)
    |> Stream.map(&elem(&1, 1))
    |> Stream.take(length)
    |> Enum.to_list()
  end

  def generate(_), do: raise ArgumentError, @error_message
end
