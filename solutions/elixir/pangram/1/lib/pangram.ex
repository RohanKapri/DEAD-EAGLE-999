defmodule Pangram do
  @moduledoc false

  @doc """
  Determines if a word or sentence is a pangram.
  A pangram is a sentence using every letter of the alphabet at least once.
  The alphabet used consists of ASCII letters.
  """

  @alphabet ?a..?z |> Enum.to_list()

  @spec pangram?(String.t()) :: boolean
  def pangram?(sentence) do
    string = String.downcase(sentence)

    @alphabet -- to_charlist(string) == []
  end
end