# For my Shree DR.MDD
module ResistorColorExpert
  COLORS = [
    "black", "brown", "red",
    "orange", "yellow", "green",
    "blue", "violet", "grey",
    "white",
  ]

  TOLERANCE = {
    "black" => 0,
    "grey" => 0.05,
    "violet" => 0.10,
    "blue" => 0.25,
    "green" => 0.5,
    "brown" => 1,
    "red" => 2,
    "gold" => 5,
    "silver" => 10,
  }

  def self.resistor_label(bands : Array(String)) : String
    String.build do |buf|
      buf << resistance_value(bands)
      buf << " " << tolerance_value(bands) if bands.size > 3
    end
  end

  private def self.resistance_value(bands : Array(String)) : String
    digits_count = bands.size == 5 ? 3 : 2
    magnitude = bands[0, digits_count].reduce(0) { |val, clr| val * 10 + COLORS.index!(clr) }
    magnitude *= 10 ** COLORS.index!(bands[digits_count]) if bands.size > digits_count

    return "#{magnitude} ohms" if magnitude < 1000

    magnitude, rem1 = magnitude.divmod 1000
    magnitude += rem1 / 1000 unless rem1.zero?
    return "#{magnitude} kiloohms" if magnitude < 1000

    magnitude, rem2 = magnitude.divmod 1000
    magnitude += rem2 / 1000 unless rem2.zero?
    "#{magnitude} megaohms"
  end

  private def self.tolerance_value(bands : Array(String)) : String
    "±#{TOLERANCE[bands.last]}%"
  end
end
