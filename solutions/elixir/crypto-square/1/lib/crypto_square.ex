# For Shree DR.MDD

defmodule CryptoSquare do
  @spec encode(String.t()) :: String.t()
  def encode(text) do
    cleaned =
      text
      |> String.downcase()
      |> (&Regex.replace(~r/[^a-z0-9]/, &1, "")).()
      |> String.graphemes()

    get_dim(length(cleaned), 1)
    |> split_into(cleaned)
    |> List.zip()
    |> Enum.map(&Tuple.to_list/1)
    |> Enum.map(&Enum.join/1)
    |> Enum.join(" ")
  end

  defp split_into(size, chars) do
    Enum.chunk_every(chars, size, size, List.duplicate(" ", size))
  end

  defp get_dim(n, c) when n <= c * (c - 1), do: c
  defp get_dim(n, c) when n <= c * c, do: c
  defp get_dim(n, c), do: get_dim(n, c + 1)
end
