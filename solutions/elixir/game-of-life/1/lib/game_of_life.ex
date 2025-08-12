defmodule GameOfLife do
  @doc """
  Apply the rules of Conway's Game of Life to a grid of cells
  """

  @offsets for x <- -1..1, y <- -1..1, x != 0 or y != 0, do: {x, y}

  @spec tick(matrix :: list(list(0 | 1))) :: list(list(0 | 1))
  def tick(matrix) do
    matrix
    |> to_map()
    |> apply_rules()
    |> to_matrix()
  end

  defp to_map(matrix) do
    matrix
    |> Enum.with_index()
    |> Enum.map(fn {list, y} ->
      list
      |> Enum.with_index()
      |> Enum.map(fn {elem, x} -> {{y, x}, elem} end)
    end)
    |> List.flatten()
    |> Map.new()
  end

  defp apply_rules(map) do
    Enum.reduce(map, %{}, fn {coord, _} = elem, acc ->
      Map.put(acc, coord, alive?(elem, map))
    end)
  end

  defp alive?({{cy, cx}, state}, map) do
    @offsets
    |> Enum.map(fn {y, x} -> {cy + y, cx + x} end)
    |> Enum.map(&Map.get(map, &1, 0))
    |> Enum.sum()
    |> then(fn
      3 -> 1
      2 when state == 1 -> 1
      _ -> 0
    end)
  end

  defp to_matrix(map) do
    map
    |> Enum.sort(fn {c1, _}, {c2, _} -> c1 <= c2 end)
    |> Enum.chunk_by(fn {{y, _}, _} -> y end)
    |> Enum.map(
      &Enum.map(&1, fn {{_, _}, state} ->
        state
      end)
    )
  end
end