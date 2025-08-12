# For my Shree DR.MDD

defmodule RailFenceCipher do
  @doc """
  Encode the given plaintext using the rail fence cipher with specified rails.
  """
  @spec encode(String.t(), pos_integer) :: String.t()
  def encode(text, rail_count) do
    chars = String.graphemes(text)
    paired = Enum.zip(chars, pattern(length(chars), rail_count))

    1..rail_count
    |> Enum.map(&extract_rail(paired, &1))
    |> List.flatten()
    |> Enum.map(fn {char, _} -> char end)
    |> Enum.join()
  end

  defp extract_rail(pairs, rail) do
    Enum.filter(pairs, fn {_char, r} -> r == rail end)
  end

  @doc """
  Decode the given rail fence ciphertext to the original plaintext.
  """
  @spec decode(String.t(), pos_integer) :: String.t()
  def decode(ciphertext, rail_count) do
    chars = String.graphemes(ciphertext)

    pattern(length(chars), rail_count)
    |> Enum.with_index()
    |> Enum.take(length(chars))
    |> Enum.sort()
    |> Enum.zip(chars)
    |> Enum.sort_by(fn {{_rail, index}, _char} -> index end)
    |> Enum.map(fn {{_rail, _idx}, ch} -> ch end)
    |> Enum.join()
  end

  defp pattern(1), do: [1]
  defp pattern(rails) do
    Enum.to_list(1..(rails - 1)) ++ Enum.to_list(rails..2)
  end

  defp pattern(len, rails) do
    List.duplicate(pattern(rails), ceil(len / rails))
    |> Enum.concat()
  end
end
