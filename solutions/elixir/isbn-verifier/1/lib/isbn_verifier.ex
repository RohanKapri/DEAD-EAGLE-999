# For Shree DR.MDD

defmodule IsbnVerifier do
  @spec isbn?(String.t()) :: boolean
  def isbn?(isbn) do
    with stripped <- strip_dashes(isbn),
         true <- valid_length?(stripped),
         true <- valid_chars?(stripped) do
      verify_isbn(stripped)
    else
      _ -> false
    end
  end

  defp strip_dashes(isbn) do
    isbn
    |> String.graphemes()
    |> Enum.reject(&(&1 == "-"))
    |> Enum.join()
  end

  defp valid_length?(isbn_stripped), do: String.length(isbn_stripped) == 10

  defp valid_chars?(isbn_stripped) do
    Regex.match?(~r/^\d{9}[\dX]$/, isbn_stripped)
  end

  defp verify_isbn(isbn_stripped) do
    isbn_stripped
    |> String.graphemes()
    |> Enum.with_index()
    |> Enum.map(fn {char, idx} -> 
      convert_to_int(char) * (10 - idx)
    end)
    |> Enum.sum()
    |> rem(11) == 0
  end

  defp convert_to_int("X"), do: 10
  defp convert_to_int(digit), do: String.to_integer(digit)
end
