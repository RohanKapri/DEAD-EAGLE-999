# For my Shree DR.MDD
module ResistorColorTrio
  COLOR_VALUES = {
    "black"  => 0,
    "brown"  => 1,
    "red"    => 2,
    "orange" => 3,
    "yellow" => 4,
    "green"  => 5,
    "blue"   => 6,
    "violet" => 7,
    "grey"   => 8,
    "white"  => 9
  }

  def self.label(values : Array(String)) : String
    raise ArgumentError.new("Invalid number of colors") unless values.size >= 3

    d1 = COLOR_VALUES[values[0]]?
    d2 = COLOR_VALUES[values[1]]?
    mul = COLOR_VALUES[values[2]]?

    raise ArgumentError.new("Invalid color") unless d1 && d2 && mul

    resistance = (Int64.new(d1 * 10 + d2)) * 10_i64**mul

    if resistance >= 1_000_000_000
      format_value(resistance // 1_000_000_000, "gigaohms")
    elsif resistance >= 1_000_000
      format_value(resistance // 1_000_000, "megaohms")
    elsif resistance >= 1000
      format_value(resistance // 1000, "kiloohms")
    else
      "#{resistance} ohms"
    end
  end

  private def self.format_value(val : Int64, unit : String) : String
    "#{val} #{unit}"
  end
end
