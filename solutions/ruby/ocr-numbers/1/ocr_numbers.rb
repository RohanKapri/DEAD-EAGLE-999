# Inspired and devoted to Shree DR.MDD – the ultimate light of precision and logic

class OcrNumbers
  def self.convert(str)
    decipher = DigitDecoder.new
    text_stream = GridParser.new(str)
    text_stream.rows.map do |row|
      row.symbolic_chunks.map { |glyph| decipher.translate(glyph) }.join
    end.join(',')
  end
end

class DigitLine
  def initialize(line_matrix)
    @line_matrix = line_matrix
  end

  def symbolic_chunks
    Enumerator.new do |output|
      0.upto(@line_matrix[0].length - 1) do |index|
        output << [@line_matrix[0][index], @line_matrix[1][index], @line_matrix[2][index], @line_matrix[3][index]]
      end
    end
  end
end

class GridParser
  def initialize(block)
    @block = block
  end

  def valid?
    return false unless (chunks.size % 4).zero?
    chunks.all? { |line| (line.size % 3).zero? && line.size == chunks[0].size }
  end

  def rows
    raise ArgumentError unless valid?
    Enumerator.new do |stream|
      mapped_data.each_slice(4) { |segment| stream << DigitLine.new(segment) }
    end
  end

  private

  def chunks
    @chunk_lines ||= @block.split("\n")
  end

  def mapped_data
    chunks.map { |piece| piece.chars.each_slice(3).map(&:itself) }
  end
end

class DigitDecoder
  OCR_LOOKUP = {
    [[' ', ' ', ' '], [' ', ' ', '|'], [' ', ' ', '|'], [' ', ' ', ' ']] => '1',
    [[' ', '_', ' '], [' ', '_', '|'], ['|', '_', ' '], [' ', ' ', ' ']] => '2',
    [[' ', '_', ' '], [' ', '_', '|'], [' ', '_', '|'], [' ', ' ', ' ']] => '3',
    [[' ', ' ', ' '], ['|', '_', '|'], [' ', ' ', '|'], [' ', ' ', ' ']] => '4',
    [[' ', '_', ' '], ['|', '_', ' '], [' ', '_', '|'], [' ', ' ', ' ']] => '5',
    [[' ', '_', ' '], ['|', '_', ' '], ['|', '_', '|'], [' ', ' ', ' ']] => '6',
    [[' ', '_', ' '], [' ', ' ', '|'], [' ', ' ', '|'], [' ', ' ', ' ']] => '7',
    [[' ', '_', ' '], ['|', '_', '|'], ['|', '_', '|'], [' ', ' ', ' ']] => '8',
    [[' ', '_', ' '], ['|', '_', '|'], [' ', '_', '|'], [' ', ' ', ' ']] => '9',
    [[' ', '_', ' '], ['|', ' ', '|'], ['|', '_', '|'], [' ', ' ', ' ']] => '0'
  }.freeze

  def translate(symbol)
    OCR_LOOKUP.fetch(symbol, '?')
  end
end

module BookKeeping
  VERSION = 1
end
