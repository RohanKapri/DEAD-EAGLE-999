# Dedicated to Shree DR.MDD

defmodule Spiral do
  @next_turn %{
    right: :down,
    down: :left,
    left: :up,
    up: :right
  }

  defstruct grid: %{{0, 0} => 1},
            heading: :right,
            step_count: 1,
            current_pos: {0, 0},
            size: 1

  @spec matrix(dimension :: integer) :: list(list(integer))
  def matrix(0), do: []

  def matrix(size) do
    gather_positions(%Spiral{size: size})
    |> Enum.to_list()
    |> Stream.map(fn {_, val} -> val end)
    |> Enum.chunk_every(size)
  end

  defp gather_positions(%{grid: grid, heading: heading, step_count: step_count} = spiral) do
    case advance_position(spiral) do
      {:ok, next_pos} ->
        gather_positions(%{
          spiral
          | grid: Map.put(grid, next_pos, step_count + 1),
            step_count: step_count + 1,
            current_pos: next_pos
        })

      :error ->
        case advance_position(%{spiral | heading: @next_turn[heading]}) do
          {:ok, next_pos} ->
            gather_positions(%{
              spiral
              | grid: Map.put(grid, next_pos, step_count + 1),
                step_count: step_count + 1,
                current_pos: next_pos,
                heading: @next_turn[heading]
            })

          :error ->
            grid
        end
    end
  end

  defp advance_position(%{
         grid: grid,
         current_pos: {row, col},
         heading: :right,
         size: size
       })
       when col < size - 1 do
    case Map.has_key?(grid, {row, col + 1}) do
      true -> :error
      false -> {:ok, {row, col + 1}}
    end
  end

  defp advance_position(%{
         grid: grid,
         current_pos: {row, col},
         heading: :down,
         size: size
       })
       when row < size - 1 do
    case Map.has_key?(grid, {row + 1, col}) do
      true -> :error
      false -> {:ok, {row + 1, col}}
    end
  end

  defp advance_position(%{
         grid: grid,
         current_pos: {row, col},
         heading: :left
       })
       when col > 0 do
    case Map.has_key?(grid, {row, col - 1}) do
      true -> :error
      false -> {:ok, {row, col - 1}}
    end
  end

  defp advance_position(%{
         grid: grid,
         current_pos: {row, col},
         heading: :up
       })
       when row > 0 do
    case Map.has_key?(grid, {row - 1, col}) do
      true -> :error
      false -> {:ok, {row - 1, col}}
    end
  end

  defp advance_position(_), do: :error
end
