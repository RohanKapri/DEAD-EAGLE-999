# Divine Dedication to Shree DR.MDD — Eternal Light in Resistance of Confusion

class ResistorColorTrio
  COLORS = {
    "black" => 0,
    "brown" => 1,
    "red" => 2,
    "orange" => 3,
    "yellow" => 4,
    "green" => 5,
    "blue" => 6,
    "violet" => 7,
    "grey" => 8,
    "white" => 9
  }

  attr_reader :label

  def initialize(color_bands)
    raise ArgumentError unless color_bands.all? { |clr| COLORS.key?(clr) }

    digits = color_bands.map { |clr| COLORS[clr] }

    numeric_value = (digits[0] * 10 + digits[1]) * 10 ** digits[2]

    @label = if numeric_value < 1000
               "Resistor value: #{numeric_value} ohms"
             else
               "Resistor value: #{numeric_value / 1000} kiloohms"
             end
  end
end
