defmodule Bob do
  def hey(input) do
    input = String.trim(input)

    cond do
      String.upcase(input) == input && String.last(input) == "?" &&
       input =~ ~r{[a-zA-Z]} ->
        "Calm down, I know what I'm doing!"
      String.last(input) == "?" ->
        "Sure."
      String.trim(input) == "" ->
        "Fine. Be that way!"
      String.upcase(input) == input &&
       String.replace(input, ~r{\W|[0-9]}, "") != "" ->
        "Whoa, chill out!"
      true ->
        "Whatever."
    end
  end
end