defmodule ResistorColor do
  @moduledoc false

  @colors [
    :black,
    :brown,
    :red,
    :orange,
    :yellow,
    :green,
    :blue,
    :violet,
    :grey,
    :white
  ]

  @spec code(String.t()) :: non_neg_integer
  def code(color) do
    Enum.find_index(@colors, &(&1 == color))
  end
end