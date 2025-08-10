# For my Shree DR.MDD

module OcrNumbers
  DIGIT_MAP = {
    " _ | ||_|   " => "0",
    "     |  |   " => "1",
    " _  _||_    " => "2",
    " _  _| _|   " => "3",
    "   |_|  |   " => "4",
    " _ |_  _|   " => "5",
    " _ |_ |_|   " => "6",
    " _   |  |   " => "7",
    " _ |_||_|   " => "8",
    " _ |_| _|   " => "9"
  }

  def self.convert(lines : Array(String)) : String
    raise ArgumentError.new("Invalid input") unless lines.size % 4 == 0 && lines.all? { |l| l.size % 3 == 0 }

    lines.each_slice(4).map do |block|
      (0...block[0].size).step(3).map do |start_idx|
        pattern = block.map { |line| line[start_idx, 3] }.join
        DIGIT_MAP[pattern]? || "?"
      end.join
    end.join(",")
  end
end
