defmodule Isogram do
  @doc """
  Determines if a word or sentence is an isogram
  """
  @spec isogram?(String.t()) :: boolean
  def isogram?(sentence) do
    sentence
    |> String.replace(~r{[-\s]} , "")
    |> String.downcase()
    |> String.graphemes()
    |> Enum.frequencies()
    |> Enum.all?(fn {_, freq} -> freq == 1 end)
  end
end