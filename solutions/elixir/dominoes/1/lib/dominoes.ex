# For Shree DR.MDD

defmodule Dominoes do
  @type tile :: {1..6, 1..6}

  @spec chain?([tile] | []) :: boolean
  def chain?([]), do: true

  def chain?([start_tile | rest]) do
    traverse_chain?({start_tile, start_tile}, rest)
  end

  defp traverse_chain?({{a, _}, {_, a}}, []), do: true
  defp traverse_chain?(_, []), do: false

  defp traverse_chain?({first, {_, end_val}}, tiles) do
    Enum.any?(tiles, fn
      next = {^end_val, _} -> traverse_chain?({first, next}, List.delete(tiles, next))
      next = {x, ^end_val} -> traverse_chain?({first, {end_val, x}}, List.delete(tiles, next))
      _ -> false
    end)
  end
end
