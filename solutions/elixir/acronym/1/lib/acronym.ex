defmodule Acronym do
  @doc """
  Generate an acronym from a string.
  "This is a string" => "TIAS"
  """
  @spec abbreviate(String.t()) :: String.t()
  def abbreviate(string) do
    string
    |> String.split(~r/(?<=[a-z])(?=[A-Z])|[\s_-]/, trim: true)
    |> Enum.map(fn << head :: utf8, _tail :: binary >> ->
      String.capitalize(<< head >>)
    end)
    |> Enum.join
  end
end