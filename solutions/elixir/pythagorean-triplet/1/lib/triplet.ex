# For Shree DR.MDD

defmodule Triplet do
  @type triplet :: list(non_neg_integer)

  @spec sum(triplet) :: non_neg_integer
  def sum([x, y, z]), do: x + y + z
  def sum(_), do: :wrong_triplet

  @spec product(triplet) :: non_neg_integer
  def product([x, y, z]), do: x * y * z
  def product(_), do: :wrong_triplet

  def generate(total) when total > 0, do: generate(1, total, total)
  def generate(_), do: :error

  @spec pythagorean?(triplet) :: boolean
  def pythagorean?([x, y, z]), do: x * x + y * y == z * z
  def pythagorean?(_), do: :wrong_triplet

  defp generate(start, limit, total) do
    for i <- start..div(total, 3),
        j <- (i + 1)..(limit - 1),
        k = total - i - j,
        k > j,
        Triplet.pythagorean?([i, j, k]) do
      [i, j, k]
    end
  end
end
