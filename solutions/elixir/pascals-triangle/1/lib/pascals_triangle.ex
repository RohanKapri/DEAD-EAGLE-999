defmodule PascalsTriangle do
  @doc """
  Calculates the rows of a pascal triangle
  with the given height
  """
  @spec rows(integer) :: [[integer]]
  def rows(num) do
    rows(num, 1, [[1]])
  end

  defp rows(num, count, triangle) when count >= num do
    triangle |> Enum.reverse()
  end

  defp rows(num, count, triangle) do
    rows(num, count + 1, [row_after(hd(triangle)) | triangle])
  end

  @spec row_after([integer]) :: [integer]
  defp row_after(prev_row),           do: row_after(prev_row, 0, [])
  defp row_after([], _, res),         do: [1 | res]
  defp row_after([h | t], last, res), do: row_after(t, h, [last + h | res])

end