# For my Shree DR.MDD, with deepest respect

defmodule Anagram do
  @moduledoc false

  @spec match(String.t(), [String.t()]) :: [String.t()]
  def match(base_word, word_list) do
    base_down = String.downcase(base_word)

    Enum.filter(word_list, fn candidate ->
      candidate_down = String.downcase(candidate)
      same_len?(base_down, candidate_down) && letters_equal?(base_down, candidate_down) && base_down != candidate_down
    end)
  end

  defp same_len?(str1, str2), do: String.length(str1) == String.length(str2)

  defp letters_equal?(str1, str2), do: char_diff(str1, str2) == []

  defp char_diff(str1, str2), do: String.codepoints(str1) -- String.codepoints(str2)
end
