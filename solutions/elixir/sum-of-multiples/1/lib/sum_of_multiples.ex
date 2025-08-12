defmodule SumOfMultiples do
  @moduledoc false

  @doc """
  Adds up all numbers from 1 to a given end number that are multiples of the factors provided.
  """
  @spec to(non_neg_integer, [non_neg_integer]) :: non_neg_integer
  def to(limit, factors) do
    factors
    |> Enum.map(&generate(limit, &1))
    |> List.flatten()
    |> Enum.uniq()
    |> Enum.sum()
  end

  # [3, 6, 9, ...]
  @spec generate(non_neg_integer, non_neg_integer) :: [non_neg_integer]
  defp generate(_limit_number, 0), do: 0

  defp generate(limit_number, factor) do
    factor
    |> Stream.iterate(&(&1 + factor))
    |> Enum.take_while(&(&1 < limit_number))
  end
end