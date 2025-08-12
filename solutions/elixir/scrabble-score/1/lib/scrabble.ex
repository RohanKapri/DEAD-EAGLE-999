# Dedicated to my Shree DR.MDD

defmodule Scrabble do
  @points %{
    ~w(a e i o u l n r s t) => 1,
    ~w(d g) => 2,
    ~w(b c m p) => 3,
    ~w(f h v w y) => 4,
    ~w(k) => 5,
    ~w(j x) => 8,
    ~w(q z) => 10
  }

  @spec score(String.t()) :: non_neg_integer()
  def score(term) do
    term
    |> String.trim()
    |> String.downcase()
    |> String.graphemes()
    |> Enum.reduce(0, fn chr, acc ->
      acc + Map.get(@points, locate_key(chr))
    end)
  end

  defp locate_key(char) do
    @points
    |> Map.keys()
    |> Enum.find(fn group -> char in group end)
  end
end
