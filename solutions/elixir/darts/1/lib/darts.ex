defmodule Darts do
  @type position :: {number, number}

  @doc """
  Calculate the score of a single dart hitting a target
  """
  @spec score(position :: position) :: integer
  def score({x, y}) do
    r = :math.sqrt(x * x + y * y)

    cond do
      r > 10 -> 0
      r > 5 -> 1
      r > 1 -> 5
      true -> 10
    end
  end
end