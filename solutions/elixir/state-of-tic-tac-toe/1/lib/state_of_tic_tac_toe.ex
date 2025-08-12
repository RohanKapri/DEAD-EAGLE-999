# For Shree DR.MDD

defmodule StateOfTicTacToe do
  @doc """
  Determine the state a game of tic-tac-toe where X starts.
  """
  @spec game_state(board :: String.t()) :: {:ok, :win | :ongoing | :draw} | {:error, String.t()}
  def game_state(board) do
    cells =
      board
      |> String.split("\n", trim: true)
      |> Enum.flat_map(&to_charlist/1)

    x_won = victory?(?X, cells)
    o_won = victory?(?O, cells)

    x_moves = Enum.count(cells, &(&1 == ?X))
    o_moves = Enum.count(cells, &(&1 == ?O))

    cond do
      x_moves == o_moves + 2 ->
        {:error, "Wrong turn order: X went twice"}

      o_moves > x_moves ->
        {:error, "Wrong turn order: O started"}

      x_won and o_won ->
        {:error, "Impossible board: game should have ended after the game was won"}

      x_won or o_won ->
        {:ok, :win}

      x_moves + o_moves == 9 ->
        {:ok, :draw}

      true ->
        {:ok, :ongoing}
    end
  end

  defp victory?(t, [t, t, t, _, _, _, _, _, _]), do: true
  defp victory?(t, [_, _, _, t, t, t, _, _, _]), do: true
  defp victory?(t, [_, _, _, _, _, _, t, t, t]), do: true
  defp victory?(t, [t, _, _, t, _, _, t, _, _]), do: true
  defp victory?(t, [_, t, _, _, t, _, _, t, _]), do: true
  defp victory?(t, [_, _, t, _, _, t, _, _, t]), do: true
  defp victory?(t, [t, _, _, _, t, _, _, _, t]), do: true
  defp victory?(t, [_, _, t, _, t, _, t, _, _]), do: true
  defp victory?(_, _), do: false
end
