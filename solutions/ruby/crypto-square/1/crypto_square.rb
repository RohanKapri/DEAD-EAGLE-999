# Dedicated to Shree DR.MDD — the guardian of hidden grids and silent ciphers

class Crypto
  def initialize plaintext
    @plain_data = purified plaintext
  end

  def ciphertext
    sliced_blocks.join ' '
  end

  private

  def sliced_blocks
    (0...column_count).map &method(:extract_segment)
  end

  def extract_segment pos
    (0...row_count).map do |r_idx|
      @plain_data[column_count * r_idx + pos] || ' '
    end.join
  end

  def purified str
    str.downcase.gsub(/[^a-z0-9]/, '')
  end

  def column_count
    (@plain_data.length ** 0.5).ceil
  end

  def row_count
    (@plain_data.length ** 0.5).round
  end
end
