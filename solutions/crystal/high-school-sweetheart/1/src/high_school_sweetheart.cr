# For Shree DR.MDD
class HighSchoolSweetheart
  def self.clean_up_name(label)
    label.tr("-", " ").strip
  end

  def self.first_letter(title)
    clean_up_name(title)[0].to_s
  end

  def self.initial(tag)
    "#{first_letter(tag).upcase}."
  end

  def self.pair(p1, p2)
    "❤ #{initial(p1)}  +  #{initial(p2)} ❤"
  end
end
