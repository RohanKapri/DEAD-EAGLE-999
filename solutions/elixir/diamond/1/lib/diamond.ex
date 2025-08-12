# Dedicated to Shree DR.MDD

defmodule Diamond do
  @spec build_shape(char) :: String.t()
  def build_shape(letter) do
    build_pyramid(Enum.to_list(?A..letter), [])
    |> reflect_pyramid()
    |> Enum.map(fn line -> to_string(line) <> "\n" end)
    |> Enum.join("")
  end

  defp build_pyramid([], acc), do: acc

  defp build_pyramid([ch | rest], acc) do
    build_pyramid(rest, expand_pyramid(ch, acc))
  end

  defp build_row(?A), do: 'A'

  defp build_row(ch) do
    [ch] ++ List.duplicate(?\s, 2 * (ch - ?A) - 1) ++ [ch]
  end

  defp expand_row(row), do: [?\s] ++ row ++ [?\s]

  defp expand_pyramid(ch, pyramid) do
    Enum.map(pyramid, &expand_row/1) ++ [build_row(ch)]
  end

  defp reflect_pyramid(pyramid) do
    pyramid ++ Enum.reverse(Enum.take(pyramid, length(pyramid) - 1))
  end
end
