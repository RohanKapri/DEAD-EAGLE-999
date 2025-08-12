defmodule SquareRoot do
  @doc """
  Calculate the integer square root of a positive integer
  https://en.wikipedia.org/wiki/Integer_square_root
  """
  @spec calculate(radicand :: pos_integer) :: pos_integer
  def calculate(1), do: 1

  def calculate(radicand) do
    estimate = div(radicand, 2)
    calculate(radicand, estimate)
  end

  def calculate(radicand, estimate) do
    next_estimate = div(estimate + div(radicand, estimate), 2)

    if next_estimate == estimate do
      estimate
    else
      calculate(radicand, next_estimate)
    end
  end
end