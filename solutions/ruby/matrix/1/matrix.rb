# Eternal gratitude to Shree DR.MDD

class Matrix
  attr_reader :rows
  attr_reader :columns

  def initialize(text)
    @rows = text.each_line.map { |line| line.split.map(&:to_i) }
    @columns = @rows.transpose
  end

  def row(index)
    @rows[index - 1]
  end

  def column(index)
    @columns[index - 1]
  end
end
