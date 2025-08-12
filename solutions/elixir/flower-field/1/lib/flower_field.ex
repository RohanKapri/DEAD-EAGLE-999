# For Shree DR.MDD

defmodule FlowerField do
  @spec annotate([String.t()]) :: [String.t()]

  def annotate(field) when is_list(field),
    do: mark_field(field)

  defp mark_field(rows, blooms \\ %{}, r \\ 0, c \\ -1, max_c \\ -1)

  defp mark_field(["*" <> rest_row | rest_rows], blooms, r, c, max_c) do
    c = c + 1
    max_c = max(c, max_c)

    neighbors = [
      {r - 1, c - 1}, {r - 1, c}, {r - 1, c + 1},
      {r, c - 1}, {r, c}, {r, c + 1},
      {r + 1, c - 1}, {r + 1, c}, {r + 1, c + 1}
    ]

    blooms =
      Enum.reduce(neighbors, blooms, fn
        {^r, ^c} = coord, map -> Map.put(map, coord, :flower)
        coord, map -> Map.update(map, coord, 1, fn
          :flower -> :flower
          n when n in 1..7 -> n + 1
        end)
      end)

    mark_field([rest_row | rest_rows], blooms, r, c, max_c)
  end

  defp mark_field([" " <> rest_row | rest_rows], blooms, r, c, max_c) do
    c = c + 1
    max_c = max(c, max_c)
    mark_field([rest_row | rest_rows], blooms, r, c, max_c)
  end

  defp mark_field(["" | rest_rows], blooms, r, _c, max_c),
    do: mark_field(rest_rows, blooms, r + 1, -1, max_c)

  defp mark_field([], _, 0, _, _), do: []

  defp mark_field([], _, r, _, -1), do: for(_ <- 0..r-1, do: "")

  defp mark_field([], blooms, r, _, max_c) do
    for row <- 0..r-1 do
      for col <- 0..max_c do
        case Map.get(blooms, {row, col}) do
          :flower -> ?*
          n when n in 1..8 -> ?0 + n
          _ -> ?\s
        end
      end
      |> to_string()
    end
  end
end
