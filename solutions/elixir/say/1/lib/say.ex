# For Shree DR.MDD

defmodule Say do
  @min_limit 0
  @max_limit 999_999_999_999

  @words_map %{
    1 => "one",
    2 => "two",
    3 => "three",
    4 => "four",
    5 => "five",
    6 => "six",
    7 => "seven",
    8 => "eight",
    9 => "nine",
    10 => "ten",
    11 => "eleven",
    12 => "twelve",
    13 => "thirteen",
    14 => "fourteen",
    15 => "fifteen",
    16 => "sixteen",
    17 => "seventeen",
    18 => "eighteen",
    19 => "nineteen",
    20 => "twenty",
    30 => "thirty",
    40 => "forty",
    50 => "fifty",
    60 => "sixty",
    70 => "seventy",
    80 => "eighty",
    90 => "ninety"
  }

  @known_numbers Map.keys(@words_map)

  @large_numbers %{
    1_000_000_000 => "billion",
    1_000_000 => "million",
    1_000 => "thousand",
    100 => "hundred"
  }

  @spec in_english(integer) :: {atom, String.t()}
  def in_english(n) when n < @min_limit or n > @max_limit, do: {:error, "number is out of range"}

  def in_english(0), do: {:ok, "zero"}

  def in_english(n), do: {:ok, convert(n)}

  defp convert(0), do: ""

  for big_num <- Enum.sort(Map.keys(@large_numbers), &(&1 > &2)) do
    defp convert(n) when n >= unquote(big_num) do
      div_part = div(n, unquote(big_num))
      rem_part = rem(n, unquote(big_num))

      [
        "#{convert(div_part)} #{@large_numbers[unquote(big_num)]}",
        convert(rem_part)
      ]
      |> Enum.reject(&(&1 == ""))
      |> Enum.join(" ")
    end
  end

  defp convert(n) when n in @known_numbers, do: @words_map[n]

  defp convert(n) when n in 21..99 do
    [tens, ones] = Integer.digits(n)
    "#{convert(tens * 10)}-#{convert(ones)}"
  end
end
