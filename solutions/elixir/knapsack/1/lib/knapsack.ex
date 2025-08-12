defmodule Knapsack do
  @type item :: %{value: integer, weight: integer}

  @doc """
  Return the maximum value that a knapsack can carry.
  """
  @spec maximum_value(items :: [item()], remaining_capacity :: integer) :: integer
  def maximum_value([], _remaining_capacity), do: 0

  def maximum_value([%{weight: w} | rest], remaining_capacity) when w > remaining_capacity do
    maximum_value(rest, remaining_capacity)
  end

  def maximum_value([%{weight: w, value: v} | rest], remaining_capacity) do
    with_item = maximum_value(rest, remaining_capacity - w) + v
    without_item = maximum_value(rest, remaining_capacity)

    max(with_item, without_item)
  end
end