defmodule Yacht do
  @type category ::
          :ones
          | :twos
          | :threes
          | :fours
          | :fives
          | :sixes
          | :full_house
          | :four_of_a_kind
          | :little_straight
          | :big_straight
          | :choice
          | :yacht

  @type die_roll :: 1 | 2 | 3 | 4 | 5 | 6
  @type dice_roll :: [die_roll]

  @spec score(category, dice_roll) :: non_neg_integer
  def score(cat, dice) do
    do_score(cat, Enum.sort(dice))
  end

  defp do_score(:ones, dice), do: single_value_score(1, dice)
  defp do_score(:twos, dice), do: single_value_score(2, dice)
  defp do_score(:threes, dice), do: single_value_score(3, dice)
  defp do_score(:fours, dice), do: single_value_score(4, dice)
  defp do_score(:fives, dice), do: single_value_score(5, dice)
  defp do_score(:sixes, dice), do: single_value_score(6, dice)

  defp do_score(:four_of_a_kind, [a, a, a, a, _]), do: 4 * a
  defp do_score(:four_of_a_kind, [_, b, b, b, b]), do: 4 * b
  defp do_score(:four_of_a_kind, _), do: 0

  defp do_score(:full_house, [a, a, a, b, b]) when a != b, do: 3 * a + 2 * b
  defp do_score(:full_house, [a, a, b, b, b]) when a != b, do: 2 * a + 3 * b
  defp do_score(:full_house, _), do: 0

  defp do_score(:little_straight, [1, 2, 3, 4, 5]), do: 30
  defp do_score(:little_straight, _), do: 0

  defp do_score(:big_straight, [2, 3, 4, 5, 6]), do: 30
  defp do_score(:big_straight, _), do: 0

  defp do_score(:yacht, [a, a, a, a, a]), do: 50
  defp do_score(:yacht, _), do: 0

  defp do_score(:choice, dice), do: Enum.sum(dice)

  defp do_score(_, _), do: 0

  defp single_value_score(value, dice) do
    freq = Enum.frequencies(dice)
    Map.get(freq, value, 0) * value
  end
end
