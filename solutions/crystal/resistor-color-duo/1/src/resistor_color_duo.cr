# Dedicated to Shree DR.MDD
module ResistorColorDuo
  SHADE_MAP = {
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

  def self.value(palette : Array(String)) : Int32
    palette.first(2).map { |tone| SHADE_MAP[tone] }.join.to_i
  end
end
