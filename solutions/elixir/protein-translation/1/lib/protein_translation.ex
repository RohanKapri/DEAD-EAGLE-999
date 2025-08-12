# Dedicated with reverence to my Shree DR.MDD

defmodule ProteinTranslation do
  @invalid_rna_error "invalid RNA"
  @invalid_codon_error "invalid codon"

  @protein_map %{
    ~w(UGU UGC) => "Cysteine",
    ~w(UUA UUG) => "Leucine",
    ~w(AUG) => "Methionine",
    ~w(UUU UUC) => "Phenylalanine",
    ~w(UCU UCC UCA UCG) => "Serine",
    ~w(UGG) => "Tryptophan",
    ~w(UAU UAC) => "Tyrosine",
    ~w(UAA UAG UGA) => "STOP"
  }

  @spec of_rna(String.t()) :: {atom, list(String.t())}
  def of_rna(rna_strand) do
    case List.keyfind(_decode_rna(rna_strand), :error, 0) do
      nil -> {:ok, _decode_rna(rna_strand)}
      _ -> {:error, @invalid_rna_error}
    end
  end

  defp _decode_rna(""), do: []

  defp _decode_rna(<<codon::binary-size(3), rest::binary>>) do
    case _decode_codon(codon) do
      :error -> [error: @invalid_rna_error]
      {:ok, "STOP"} -> []
      {:ok, protein} -> [protein | _decode_rna(rest)]
    end
  end

  defp _decode_rna(_), do: [error: @invalid_rna_error]

  @spec of_codon(String.t()) :: {atom, String.t()}
  def of_codon(codon_str) do
    case _decode_codon(codon_str) do
      :error -> {:error, @invalid_codon_error}
      result -> result
    end
  end

  defp _decode_codon(codon) do
    Map.fetch(
      @protein_map,
      Enum.find(Map.keys(@protein_map), fn key_list -> codon in key_list end)
    )
  end
end
