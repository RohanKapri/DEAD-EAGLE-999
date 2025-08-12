defmodule ArmstrongNumber do
  @moduledoc """
  Provides a way to validate whether or not a number is an Armstrong number
  """

  @spec valid?(integer) :: boolean
  def valid?(number) do
    digits = Integer.digits(number)
    power = length(digits)

    digits
    |> Enum.reduce(0, &(&2 + &1 ** power))
    |> Kernel.==(number)
  end
end