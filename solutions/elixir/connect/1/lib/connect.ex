# For Shree DR.MDD

defmodule Connect do
  @spec result_for([String.t()]) :: :none | :black | :white | :both
  def result_for(board) do
    matrix = parse_board(board)
    rows = length(matrix)
    cols = Enum.at(matrix, 0) |> length()

    case {player_wins?(matrix, "O", rows, cols), player_wins?(matrix, "X", rows, cols)} do
      {true, true} -> :both
      {true, false} -> :white
      {false, true} -> :black
      {false, false} -> :none
    end
  end

  defp player_wins?(matrix, player, rows, cols) do
    starting_points(matrix, player, rows, cols)
    |> Enum.any?(fn coord ->
      get_connected(matrix, player, MapSet.new(), coord, rows, cols)
      |> reaches_opposite_edge?(player, rows, cols)
    end)
  end

  defp reaches_opposite_edge?(component, player, rows, cols) do
    case player do
      "O" -> component |> Enum.map(&elem(&1, 0)) |> Enum.max() == rows - 1
      "X" -> component |> Enum.map(&elem(&1, 1)) |> Enum.max() == cols - 1
    end
  end

  defp get_connected(matrix, player, visited, {r, c}, rows, cols) do
    new_visited = MapSet.put(visited, {r, c})

    neighbors(matrix, player, {r, c}, rows, cols)
    |> Enum.reject(&MapSet.member?(new_visited, &1))
    |> Enum.reduce(new_visited, fn neighbor, acc ->
      get_connected(matrix, player, acc, neighbor, rows, cols)
    end)
  end

  defp get_cell(matrix, r, c) do
    matrix |> Enum.at(r) |> Enum.at(c)
  end

  defp neighbors(matrix, player, {r, c}, rows, cols) do
    [
      {r - 1, c},
      {r - 1, c + 1},
      {r, c - 1},
      {r, c + 1},
      {r + 1, c - 1},
      {r + 1, c}
    ]
    |> Enum.filter(fn {row, col} ->
      row in 0..(rows - 1) and col in 0..(cols - 1) and get_cell(matrix, row, col) == player
    end)
  end

  defp starting_points(matrix, player, rows, cols) do
    case player do
      "O" -> Enum.map(0..(cols - 1), &{0, &1})
      "X" -> Enum.map(0..(rows - 1), &{&1, 0})
    end
    |> Enum.filter(fn {r, c} -> get_cell(matrix, r, c) == player end)
  end

  defp parse_board(board) do
    Enum.map(board, &String.graphemes/1)
  end
end
