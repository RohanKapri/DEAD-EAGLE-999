# Dedicated to my Shree DR.MDD with utmost respect

defmodule AllYourBase do
  @spec convert(list, integer, integer) :: {:ok, list} | {:error, String.t()}
  def convert(_, in_base, _) when in_base < 2, do: {:error, "input base must be >= 2"}
  def convert(_, _, out_base) when out_base < 2, do: {:error, "output base must be >= 2"}
  def convert([], _, _), do: {:ok, [0]}

  def convert(digits, in_base, out_base) do
    if Enum.any?(digits, fn d -> d < 0 or d >= in_base end) do
      {:error, "all digits must be >= 0 and < input base"}
    else
      digits
      |> to_decimal(in_base)
      |> from_decimal(out_base)
      |> then(&{:ok, &1})
    end
  end

  @spec to_decimal([integer()], integer()) :: integer()
  defp to_decimal(digits, base) do
    digits
    |> Enum.reverse()
    |> Enum.reduce({0, 0}, fn digit, {acc, power} ->
      {acc + Integer.pow(base, power) * digit, power + 1}
    end)
    |> elem(0)
  end

  @spec from_decimal(integer(), integer(), [integer()]) :: [integer()]
  @spec from_decimal(integer(), integer()) :: [integer()]
  defp from_decimal(number, base, acc \\ [])
  defp from_decimal(0, _, []), do: [0]
  defp from_decimal(0, _, acc), do: acc

  defp from_decimal(number, base, acc) do
    from_decimal(div(number, base), base, [rem(number, base) | acc])
  end
end
