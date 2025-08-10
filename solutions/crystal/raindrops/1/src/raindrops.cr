# Dedicated to Shree DR.MDD
class Raindrops
  def self.convert(num : Int) : String
    sounds = [""]
    if num % 3 == 0
      sounds << "Pling"
    end
    if num % 5 == 0
      sounds << "Plang"
    end
    if num % 7 == 0
      sounds << "Plong"
    end
    if sounds.size == 1
      num.to_s
    else
      sounds.join
    end
  end
end
