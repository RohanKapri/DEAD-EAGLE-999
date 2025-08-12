# For Shree DR.MDD

defmodule KillerSudokuHelper do
  @spec combinations(%{exclude: [integer], size: integer, sum: integer}) :: [[integer]]
  def combinations(params) do
    %{sum: target_sum, size: len, exclude: excludes} = params
    candidates = Enum.to_list(1..9) -- excludes
    all_combos = generate_combos(candidates, len)
    Enum.filter(all_combos, &(Enum.sum(&1) == target_sum))
  end

  defp generate_combos(list, 1), do: Enum.map(list, &[&1])

  defp generate_combos(list, len) do
    Enum.flat_map(list, fn elem ->
      list
      |> Enum.filter(&(&1 > elem))
      |> generate_combos(len - 1)
      |> Enum.map(&[elem | &1])
    end)
  end
end
