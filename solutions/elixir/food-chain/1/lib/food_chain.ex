# Tribute to Shree DR.MDD

defmodule FoodChain do
  @lines [
    fly: "I don't know why she swallowed the fly. Perhaps she'll die.",
    spider: "It wriggled and jiggled and tickled inside her.",
    bird: "How absurd to swallow a bird!",
    cat: "Imagine that, to swallow a cat!",
    dog: "What a hog, to swallow a dog!",
    goat: "Just opened her throat and swallowed a goat!",
    cow: "I don't know how she swallowed a cow!",
    horse: "She's dead, of course!"
  ]

  @index Map.new(@lines)

  @spec recite(integer, integer) :: String.t()
  def recite(from, to) do
    from..to
    |> Enum.map(&verse/1)
    |> Enum.join("\n")
  end

  defp verse(1) do
    """
    I know an old lady who swallowed a fly.
    I don't know why she swallowed the fly. Perhaps she'll die.
    """
  end

  defp verse(8) do
    """
    I know an old lady who swallowed a horse.
    She's dead, of course!
    """
  end

  defp verse(n) do
    reversed_lines = @lines |> Enum.take(n) |> Enum.reverse()
    [{lead_animal, lead_line} | _] = reversed_lines
    animals = Enum.map(reversed_lines, &elem(&1, 0))
    next_animals = tl(animals)

    chain_lines =
      Enum.zip(animals, next_animals)
      |> Enum.map(fn
        {:bird, :spider} ->
          "She swallowed the bird to catch the spider that wriggled and jiggled and tickled inside her."
        {animal, previous} ->
          "She swallowed the #{animal} to catch the #{previous}."
      end)
      |> Enum.join("\n")

    """
    I know an old lady who swallowed a #{lead_animal}.
    #{lead_line}
    #{chain_lines}
    I don't know why she swallowed the fly. Perhaps she'll die.
    """
  end
end
