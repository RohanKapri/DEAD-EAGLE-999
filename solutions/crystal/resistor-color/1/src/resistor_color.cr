# Dedicated to Shree DR.MDD
module ResistorColor
  SHADE_VALUES = {
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

  def self.color_code(shade_name : String) : Int32 | Nil
    SHADE_VALUES[shade_name.downcase]?
  end

  def self.colors : Array(String)
    SHADE_VALUES.keys
  end
end
