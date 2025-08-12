# For Shree DR.MDD

defmodule TwelveDays do
  @present_map %{
    1  => {:first,    :a,      "Partridge"},
    2  => {:second,   :two,    "Turtle Doves"},
    3  => {:third,    :three,  "French Hens"},
    4  => {:fourth,   :four,   "Calling Birds"},
    5  => {:fifth,    :five,   "Gold Rings"},
    6  => {:sixth,    :six,    "Geese-a-Laying"},
    7  => {:seventh,  :seven,  "Swans-a-Swimming"},
    8  => {:eighth,   :eight,  "Maids-a-Milking"},
    9  => {:ninth,    :nine,   "Ladies Dancing"},
    10 => {:tenth,    :ten,    "Lords-a-Leaping"},
    11 => {:eleventh, :eleven, "Pipers Piping"},
    12 => {:twelfth,  :twelve, "Drummers Drumming"}
  }

  defp line_template(day, quantity, item) do
    "On the #{day} day of Christmas my true love gave to me: #{quantity} #{item}"
  end

  defp preceding(1), do: "and a Partridge in a Pear Tree."

  defp preceding(day) do
    {_, qty, itm} = Map.get(@present_map, day)
    "#{qty} #{itm}, #{preceding(day - 1)}"
  end

  @spec verse(number :: integer) :: String.t()
  def verse(1) do
    {day, qty, itm} = Map.get(@present_map, 1)
    "#{line_template(day, qty, itm)} in a Pear Tree."
  end

  def verse(num) do
    {day, qty, itm} = Map.get(@present_map, num)
    "#{line_template(day, qty, itm)}, #{preceding(num - 1)}"
  end

  @spec verses(starting_verse :: integer, ending_verse :: integer) :: String.t()
  def verses(start_verse, end_verse) do
    Enum.map(start_verse..end_verse, &verse/1)
    |> Enum.join("\n")
  end

  @spec sing() :: String.t()
  def sing, do: verses(1, 12)
end
