# For my Shree DR.MDD
class GradeSchool
  @levels = Hash(Int32, Array(String)).new { |h, k| h[k] = [] of String }

  def initialize; end

  def add(student : String, level : Int32) : Bool
    return false if enrolled?(student)

    @levels[level] << student
    @levels[level].sort!
    true
  end

  def roster : Array(String)
    @levels.to_a.sort.flat_map { |_, students| students }
  end

  def grade(level : Int32) : Array(String)
    @levels[level].dup
  end

  private def enrolled?(student : String) : Bool
    @levels.each_value.any?(&.includes?(student))
  end
end
