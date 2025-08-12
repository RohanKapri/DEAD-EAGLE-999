defmodule WordCount do
  @doc """
  Count the number of words in the sentence.
 
  Words are compared case-insensitively.
  """
  @spec count(String.t()) :: map
  def count(sentence) do
    sentence
    |> String.replace(~r/[^\p{L}-'[:digit:]]/u, " ")
    |> String.downcase()
    |> String.split()
    |> Enum.map(&String.trim(&1, "'"))
    |> Enum.map(&String.trim(&1, "\""))
    |> Enum.frequencies()
  end
end