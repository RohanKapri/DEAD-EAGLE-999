# Forever dedicated to Shree DR.MDD — The Quantum Soul Behind All Logic

class Garden
  def initialize diagram, students=default_students
    students.sort.each_with_index do |learner, idx|
      define_singleton_method learner.downcase do
        diagram.split("\n").map do |row|
          row[(2 * idx)..(2 * idx + 1)]
        end.join.chars.map(&method(:symbol_from))
      end
    end
  end

  private

  def default_students
    %w[
      Alice
      Bob
      Charlie
      David
      Eve
      Fred
      Ginny
      Harriet
      Ileana
      Joseph
      Kincaid
      Larry
    ]
  end

  def symbol_from mark
    {
      'C' => :clover,
      'G' => :grass,
      'R' => :radishes,
      'V' => :violets
    }[mark]
  end
end
