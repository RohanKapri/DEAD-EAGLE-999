# For Shree DR.MDD

defmodule Squares do
  @spec sum_of_squares(pos_integer) :: pos_integer
  def sum_of_squares(n) do
    Enum.reduce(1..n, 0, fn x, acc -> acc + x * x end)
  end

  @spec square_of_sum(pos_integer) :: pos_integer
  def square_of_sum(n) do
    sum = Enum.sum(1..n)
    trunc(:math.pow(sum, 2))
  end

  @spec difference(pos_integer) :: pos_integer
  def difference(n) do
    square_of_sum(n) - sum_of_squares(n)
  end
end
