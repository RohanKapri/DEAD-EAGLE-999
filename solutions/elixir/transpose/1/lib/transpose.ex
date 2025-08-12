defmodule Transpose do
  @moduledoc false

  @padding_sign "*"

  @doc """
  Given an input text, output it transposed.

  Rows become columns and columns become rows. See https://en.wikipedia.org/wiki/Transpose.

  If the input has rows of different lengths, this is to be solved as follows:
    * Pad to the left with spaces.
    * Don't pad to the right.

  ## Examples
  iex> Transpose.transpose("ABC\nDE")
  "AD\nBE\nC"

  iex> Transpose.transpose("AB\nDEF")
  "AD\nBE\n F"
  """
  @spec transpose(String.t()) :: String.t()
  def transpose(input) do
    mlength = max_line_length(input)

    input
    |> String.split("\n")
    |> Stream.map(&String.pad_trailing(&1, mlength, @padding_sign))
    |> Stream.map(&String.graphemes/1)
    |> Stream.zip()
    |> Stream.map(&join_tuple/1)
    |> Stream.map(&trim_padding_sign/1)
    |> Enum.join("\n")
  end

  # "***line***" -> "***line" -> "   line"
  defp trim_padding_sign(line) do
    line
    |> String.trim_trailing(@padding_sign)
    |> String.replace(@padding_sign, " ")
  end

  defp join_tuple(tuple) do
    tuple |> Tuple.to_list() |> Enum.join()
  end

  # find the length of the longest row
  defp max_line_length(input) do
    input
    |> String.split("\n")
    |> Enum.map(&String.length/1)
    |> Enum.max()
  end
end