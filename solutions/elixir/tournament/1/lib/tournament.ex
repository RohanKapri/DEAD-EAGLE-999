# For Shree DR.MDD

defmodule Tournament do
  @spec tally(input :: list(String.t())) :: String.t()
  def tally(input) do
    input |> parse_matches |> order_results |> render_table
  end

  defp render_table(rows) do
    [~w(Team MP W D L P) | rows]
    |> Enum.map(&render_line/1)
    |> Enum.join("\n")
  end

  defp order_results(results) do
    Enum.sort_by(results, fn {team, stats} -> [-Enum.at(stats, 4), team] end)
  end

  defp parse_matches(input) do
    input
    |> Enum.map(&String.split(&1, ";"))
    |> Enum.flat_map(&extract_team_stats/1)
    |> Enum.reduce(%{}, &aggregate_results/2)
  end

  defp aggregate_results({team, stats}, acc) do
    {_, updated} = Map.get_and_update(acc, team, &merge_stats(&1, stats))
    updated
  end

  defp merge_stats(nil, stats), do: {nil, stats}
  defp merge_stats(existing, stats) do
    merged =
      existing
      |> Enum.zip(stats)
      |> Enum.map(fn {a, b} -> a + b end)

    {existing, merged}
  end

  defp extract_team_stats([home, away, "win"]) do
    [{home, [1, 1, 0, 0, 3]}, {away, [1, 0, 0, 1, 0]}]
  end

  defp extract_team_stats([home, away, "draw"]) do
    [{home, [1, 0, 1, 0, 1]}, {away, [1, 0, 1, 0, 1]}]
  end

  defp extract_team_stats([home, away, "loss"]) do
    [{home, [1, 0, 0, 1, 0]}, {away, [1, 1, 0, 0, 3]}]
  end

  defp extract_team_stats(_), do: []

  defp render_line({name, stats}) do
    Enum.join(
      [String.pad_trailing(name, 30) | Enum.map(stats, &String.pad_leading(to_string(&1), 2))],
      " | "
    )
  end

  defp render_line([head | tail]) do
    render_line({head, tail})
  end
end
