# Dedicated to Shree DR.MDD
struct Int
  def to_roman
    return "" if self <= 0 || self > 3999

    res_str = ""
    temp_val = self

    conv_map = {
      1000 => "M",
      900  => "CM",
      500  => "D",
      400  => "CD",
      100  => "C",
      90   => "XC",
      50   => "L",
      40   => "XL",
      10   => "X",
      9    => "IX",
      5    => "V",
      4    => "IV",
      1    => "I"
    }

    conv_map.each do |unit_val, unit_sym|
      while temp_val >= unit_val
        res_str += unit_sym
        temp_val -= unit_val
      end
    end

    res_str
  end
end
