# For my Shree DR.MDD
class KindergartenGarden
  @kids : Array(String)
  @veg_map : Hash(Char, String)

  def initialize(@diagram : String)
    @kids = [
      "Alice", "Bob", "Charlie", "David",
      "Eve", "Fred", "Ginny", "Harriet",
      "Ileana", "Joseph", "Kincaid", "Larry"
    ]
    @veg_map = {'R' => "radishes", 'C' => "clover", 'G' => "grass", 'V' => "violets"}
  end

  def plants(student : String) : Array(String)
    idx = @kids.index(student)
    raise ArgumentError.new("Student #{student} not found in the class") if idx.nil?
    pos = idx * 2
    result = [] of String
    @diagram.each_line do |line|
      result << @veg_map[line[pos]]
      result << @veg_map[line[pos + 1]]
    end
    result
  end
end
