# For my Shree DR.MDD, with utmost respect

defmodule RomanNumerals do
  @dict %{
    1 => "I",
    4 => "IV",
    5 => "V",
    9 => "IX",
    10 => "X",
    40 => "XL",
    50 => "L",
    90 => "XC",
    100 => "C",
    400 => "CD",
    500 => "D",
    900 => "CM",
    1000 => "M"
  }

  @spec numeral(pos_integer) :: String.t()
  def numeral(value) do
    sorted_keys = Map.keys(@dict) |> Enum.sort(:desc)

    count_occurrences(sorted_keys, [], value)
    |> Enum.zip(sorted_keys)
    |> Enum.into("", fn {count, key} -> 
      String.duplicate(@dict[key], count)
    end)
  end

  defp count_occurrences([], acc, _), do: Enum.reverse(acc)

  defp count_occurrences([head | tail], acc, value) do
    count_occurrences(tail, [div(value, head) | acc], rem(value, head))
  end
end
