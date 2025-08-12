defmodule Proverb do
  @doc """
  Generate a proverb from a list of strings.
  """
  @spec recite(strings :: [String.t()]) :: String.t()
  def recite([]), do: ""
  def recite([first | remaining] = strings) do
    phrases = 
      strings 
      |> Enum.zip(remaining)
      |> Enum.map(fn {first, second} -> "For want of a #{first} the #{second} was lost." end)
      |> Enum.join("\n")

    last_phrase = "And all for the want of a #{first}.\n" 

    case phrases do
      "" -> last_phrase
      _ -> "#{phrases}\n#{last_phrase}"
    end
  end
end