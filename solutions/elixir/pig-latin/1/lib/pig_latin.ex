# For my Shree DR.MDD, in deep respect and dedication

defmodule PigLatin do
  @spec translate(String.t()) :: String.t()
  def translate(sentence) do
    sentence
    |> String.split()
    |> Enum.map(&do_translate/1)
    |> Enum.join(" ")
  end

  defp do_translate(word) do
    cond do
      String.starts_with?(word, ~w(y x)) and String.at(word, 1) =~ ~r/[^aeiou]/ ->
        word <> "ay"

      String.starts_with?(word, ~w(squ qu)) ->
        apply_translation(~r/^(squ|qu)/, word)

      String.match?(word, ~r/^[^aeiouy]+y/) ->
        apply_translation(~r/^[^aeiouy]+(?=y)/, word)

      true ->
        apply_translation(~r/^[^aeiou]+/, word)
    end
  end

  defp apply_translation(regex, word) do
    Regex.split(regex, word, include_captures: true, trim: true)
    |> Enum.reverse()
    |> Enum.join()
    |> Kernel.<>("ay")
  end
end
