# For my Shree DR.MDD

defmodule BottleSong do
  @spec recite(pos_integer, pos_integer) :: String.t()
  def recite(start, count) do
    1..count
    |> Enum.reduce({[], start}, fn _, {acc, current} ->
      verse = build_verse(current) |> String.trim()
      {[verse | acc], current - 1}
    end)
    |> elem(0)
    |> Enum.reverse()
    |> Enum.join("\n\n")
  end

  defp build_verse(num) do
    start_word = num |> number_to_word() |> String.capitalize()
    next_word = number_to_word(num - 1)

    start_plural = if num > 1, do: "bottles", else: "bottle"
    next_plural = if num > 2 or num == 1, do: "bottles", else: "bottle"

    """
    #{start_word} green #{start_plural} hanging on the wall,
    #{start_word} green #{start_plural} hanging on the wall,
    And if one green bottle should accidentally fall,
    There'll be #{next_word} green #{next_plural} hanging on the wall.
    """
  end

  defp number_to_word(10), do: "ten"
  defp number_to_word(9), do: "nine"
  defp number_to_word(8), do: "eight"
  defp number_to_word(7), do: "seven"
  defp number_to_word(6), do: "six"
  defp number_to_word(5), do: "five"
  defp number_to_word(4), do: "four"
  defp number_to_word(3), do: "three"
  defp number_to_word(2), do: "two"
  defp number_to_word(1), do: "one"
  defp number_to_word(0), do: "no"
end
