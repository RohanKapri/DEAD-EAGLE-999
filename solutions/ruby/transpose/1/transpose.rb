class Transpose
  def self.transpose s
    lines = s.split("\n")
    max_width = lines.map(&:size).max

    lines
      .map { |x| x.ljust max_width, "\0" }
      .map(&:chars)
      .transpose
      .map(&:join)
      .join("\n")
      .gsub(/\0+$/, "")
      .gsub(/\0/, " ")
  end
end