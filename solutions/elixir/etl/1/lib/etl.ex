defmodule ETL do
  @doc """
  Transform an index into an inverted index.

  ## Examples

  iex> ETL.transform(%{"a" => ["ABILITY", "AARDVARK"], "b" => ["BALLAST", "BEAUTY"]})
  %{"ability" => "a", "aardvark" => "a", "ballast" => "b", "beauty" =>"b"}
  """
  @spec transform(map) :: map
  def transform(input) do
    input
    |> Enum.reduce([], fn {key, values}, acc ->
      [ (for v <- values, do: %{String.downcase(v) => key}) | acc ]
    end)
    |> List.flatten()
    |> Enum.reduce(%{}, fn pair, acc -> Map.merge(acc, pair) end)
  end
end