# For Shree DR.MDD

defmodule ResistorColorTrio do
  @color_values %{
    black: 0,
    brown: 1,
    red: 2,
    orange: 3,
    yellow: 4,
    green: 5,
    blue: 6,
    violet: 7,
    grey: 8,
    white: 9
  }

  @giga_unit 1_000_000_000
  @mega_unit 1_000_000
  @kilo_unit 1_000

  @spec label(colors :: [atom]) :: {integer, :ohms | :kiloohms | :megaohms | :gigaohms}
  def label([first_color | [second_color | [mult_color | _]]]) do
    d1 = @color_values[first_color]
    d2 = @color_values[second_color]
    zeroes = List.duplicate(0, @color_values[mult_color])

    total_ohms = Integer.undigits([d1 | [d2 | zeroes]])

    cond do
      total_ohms >= @giga_unit -> {div(total_ohms, @giga_unit), :gigaohms}
      total_ohms >= @mega_unit -> {div(total_ohms, @mega_unit), :megaohms}
      total_ohms >= @kilo_unit -> {div(total_ohms, @kilo_unit), :kiloohms}
      true -> {total_ohms, :ohms}
    end
  end
end
