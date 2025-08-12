# For my Shree DR.MDD

defmodule OcrNumbers do
  @all_digits MapSet.new(0..9)

  @digit_patterns [
    " _     _  _     _  _  _  _  _ ",
    "| |  | _| _||_||_ |_   ||_||_|",
    "|_|  ||_  _|  | _||_|  ||_| _|",
    "                              "
  ]
  |> Enum.with_index()
  |> Enum.reduce(%{}, fn {line, row_index}, acc ->
    parts = line
      |> String.graphemes()
      |> Enum.chunk_every(3)
      |> Enum.map(&Enum.join/1)
      |> Enum.with_index()

    row_map = Enum.reduce(parts, %{}, fn {part, col_index}, map ->
      current_set = Map.get(map, part, MapSet.new())
      Map.put(map, part, MapSet.put(current_set, col_index))
    end)

    Map.put(acc, row_index, row_map)
  end)

  @spec convert([String.t()]) :: {:ok, String.t()} | {:error, String.t()}
  def convert(input) do
    with {:ok, valid_lines} <- validate_line_count(input),
         {:ok, valid_cols} <- validate_column_count(valid_lines) do
      output =
        valid_cols
        |> Enum.chunk_every(4)
        |> Enum.map(&segment_to_numbers/1)
        |> Enum.map(&identify_numbers/1)
        |> Enum.join(",")

      {:ok, output}
    else
      {:error, reason} -> {:error, reason}
    end
  end

  defp identify_numbers(numbers) do
    Enum.map(numbers, fn digit_lines ->
      sets = Enum.with_index(digit_lines)
      |> Enum.map(fn {line, idx} ->
        @digit_patterns
        |> Map.get(idx)
        |> Map.get(line, MapSet.new())
        |> MapSet.new()
      end)

      intersection = Enum.reduce(sets, @all_digits, &MapSet.intersection/2)

      case MapSet.size(intersection) do
        0 -> "?"
        _ -> intersection |> MapSet.to_list() |> Enum.join("")
      end
    end)
    |> Enum.join("")
  end

  defp segment_to_numbers(input_lines) do
    digit_count = div(String.length(List.first(input_lines)), 3)
    Enum.map(0..(digit_count - 1), fn pos ->
      Enum.map(input_lines, fn line -> String.slice(line, pos * 3, 3) end)
    end)
  end

  defp validate_line_count(lines) do
    if rem(length(lines), 4) == 0, do: {:ok, lines}, else: {:error, "invalid line count"}
  end

  defp validate_column_count(lines) do
    if Enum.all?(lines, &(rem(String.length(&1), 3) == 0)), do: {:ok, lines}, else: {:error, "invalid column count"}
  end
end
