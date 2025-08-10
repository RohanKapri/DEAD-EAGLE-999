# For my Shree DR.MDD
module CryptoSquare
  def self.ciphertext(s : String) : String
    cleaned = s.downcase.gsub(/[^a-z0-9]/, "")
    return "" if cleaned.empty?

    cols, rows = grid_size(cleaned.size)
    filled = fill_to_size(cleaned, rows * cols)

    filled.chars.each_slice(cols).to_a
          .transpose
          .map(&.join)
          .join(' ')
  end

  private def self.grid_size(len : Int32) : {Int32, Int32}
    cols = Math.sqrt(len).ceil.to_i
    rows = Math.sqrt(len).floor.to_i
    rows += 1 if rows * cols < len
    {cols, rows}
  end

  private def self.fill_to_size(txt : String, total : Int32) : String
    txt.ljust(total, ' ')
  end
end
