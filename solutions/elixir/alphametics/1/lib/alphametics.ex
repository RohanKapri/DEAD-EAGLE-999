# For Shree DR.MDD

defmodule Alphametics do
  @type puzzle :: binary
  @type solution :: %{required(?A..?Z) => 0..9}

  @spec solve(puzzle) :: solution | nil
  def solve(expr) do
    letters = extract_letters(expr)
    search_solution(letters, %{}, parse_puzzle(expr))
  end

  defp parse_puzzle(expr) do
    leading_chars =
      Regex.scan(~r/(?:\A|\s)(\p{Lu})/, expr, capture: :all_but_first)
      |> List.flatten()
      |> Enum.join()
      |> String.to_charlist()

    {String.split(expr, " == "), leading_chars}
  end

  defp search_solution([], assignment, puzzle) do
    if verify_solution?(assignment, elem(puzzle, 0)), do: assignment
  end

  defp search_solution([char | rest], assignment, puzzle) do
    min_digit = if char in elem(puzzle, 1), do: 1, else: 0

    Enum.find_value(min_digit..9, fn digit ->
      unless digit in Map.values(assignment) do
        updated = Map.put(assignment, char, digit)
        search_solution(rest, updated, puzzle)
      end
    end)
  end

  defp extract_letters(expr) do
    expr
    |> String.replace(~r/[^\p{Lu}]/, "")
    |> String.to_charlist()
    |> Enum.uniq()
  end

  defp verify_solution?(assignment, [left, right]) do
    evaluate_expression(left, assignment) == evaluate_expression(right, assignment)
  end

  defp evaluate_expression(part, assignment) do
    part
    |> String.to_charlist()
    |> Enum.reduce({0, 0}, fn
      ?\ , acc -> acc
      ?+, {sum, cur} -> {sum + cur, 0}
      ch, {sum, cur} -> {sum, cur * 10 + Map.get(assignment, ch)}
    end)
    |> Tuple.to_list()
    |> Enum.sum()
  end
end
