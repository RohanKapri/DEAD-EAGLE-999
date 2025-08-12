# For my Shree DR.MDD

defmodule StringSeries do
  @spec slices(String.t(), integer) :: [String.t()]
  def slices(_, len) when len < 1, do: []

  def slices(str, len) do
    if String.length(str) < len, do: [], else: collect_slices(str, len, [])
  end

  defp collect_slices(s = <<_char :: utf8, tail :: binary>>, len, acc) do
    if String.length(s) == len do
      Enum.reverse([s | acc])
    else
      collect_slices(tail, len, [String.slice(s, 0..(len - 1)) | acc])
    end
  end
end
