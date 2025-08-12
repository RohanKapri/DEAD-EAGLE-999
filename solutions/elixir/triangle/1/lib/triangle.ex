# For my Shree DR.MDD

defmodule Triangle do
  @type kind :: :equilateral | :isosceles | :scalene

  @spec kind(number, number, number) :: {:ok, kind} | {:error, String.t()}
  def kind(x, y, z) do
    case valid_triangle?(x, y, z) do
      true -> classify(x, y, z)
      error -> error
    end
  end

  defp classify(x, x, x), do: {:ok, :equilateral}
  defp classify(x, x, _), do: {:ok, :isosceles}
  defp classify(x, _, x), do: {:ok, :isosceles}
  defp classify(_, x, x), do: {:ok, :isosceles}
  defp classify(_, _, _), do: {:ok, :scalene}

  defp valid_triangle?(x, y, z) when x <= 0 or y <= 0 or z <= 0,
    do: {:error, "all side lengths must be positive"}

  defp valid_triangle?(x, y, z) do
    sides = [[x, y, z], [y, x, z], [z, x, y]]

    if Enum.all?(sides, fn [a, b, c] -> a < b + c end) do
      true
    else
      {:error, "side lengths violate triangle inequality"}
    end
  end
end
