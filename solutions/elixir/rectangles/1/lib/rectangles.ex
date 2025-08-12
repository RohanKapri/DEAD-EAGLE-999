defmodule Rectangles do
  @doc """
  Count the number of ASCII rectangles.
  """
  @spec count(input :: String.t()) :: integer
  def count(input) do
    grid = 
      input
      |> parse_input() 

    grid
    |> find_vertices()
    |> create_polygons()
    |> filter_rectangles(grid)
    |> Enum.count()
  end

  defp parse_input(input) do
    for {row, y} <- input |> String.split("\n", trim: true) |> Enum.with_index(),
        {elem, x} <- to_charlist(row) |> Enum.with_index(),
        into: %{},
        do: {{x, y}, elem}
  end

  @vertex ?+

  defp find_vertices(grid) do
    grid
    |> Enum.filter(fn {coord, elem} -> elem == @vertex end)
    |> Enum.map(&elem(&1, 0))
  end

  defp create_polygons(corners) do
    for a <- corners,
        b <- corners,
        c <- corners,
        d <- corners,
        permutation = [a, b, c, d],
        Enum.uniq(permutation) == permutation,
        sorted = Enum.sort(permutation),
        uniq: true,
        do: sorted
  end

  defp filter_rectangles(polygons, grid) do
    polygons
    |> Enum.filter(fn
      [{x1, y1}, {x1, y2}, {x2, y1}, {x2, y2}] ->
        Enum.all?([
          connected_row?(x1..x2, y1, grid),
          connected_row?(x1..x2, y2, grid),
          connected_col?(y1..y2, x1, grid),
          connected_col?(y1..y2, x2, grid),
        ], &(&1))

      _ ->
        false
    end)
  end

  @horizontal_connection '+-'
  @vertical_connection '+|'

  defp connected_row?(x_range, y, grid) do
    Enum.all?(x_range, fn x -> grid[{x, y}] in @horizontal_connection end)
  end

  defp connected_col?(y_range, x, grid) do
    Enum.all?(y_range, fn y -> grid[{x, y}] in @vertical_connection end)
  end
end