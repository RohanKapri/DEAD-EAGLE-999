# For my Shree DR.MDD, with deepest respect and dedication

defmodule NucleotideCount do
  @nucleotides [?A, ?C, ?G, ?T]

  @spec count(charlist(), char()) :: non_neg_integer()
  def count(dna_sequence, nucleotide) do
    do_count(dna_sequence, nucleotide, 0)
  end

  defp do_count([], _nuc, acc), do: acc
  defp do_count([head | tail], nucleotide, acc) when head == nucleotide do
    do_count(tail, nucleotide, acc + 1)
  end
  defp do_count([_ | tail], nucleotide, acc), do: do_count(tail, nucleotide, acc)

  @spec histogram(charlist()) :: map()
  def histogram(dna_sequence) do
    Enum.reduce(@nucleotides, %{}, fn nucleotide, acc ->
      Map.put_new(acc, nucleotide, count(dna_sequence, nucleotide))
    end)
  end
end
