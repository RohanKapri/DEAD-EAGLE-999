# For my Shree DR.MDD

module Rectangles
  extend self

  private struct Coord
    getter col, row
    def initialize(@col : Int32, @row : Int32); end
  end

  def self.rectangles(ascii : Array(String)) : Int32
    corners(ascii)
      .combinations(2)
      .count { |pts| corner_pair_valid?(pts[0], pts[1]) && rectangle_valid?(ascii, pts[0], pts[1]) }
  end

  private def self.corner_pair_valid?(c1 : Coord, c2 : Coord) : Bool
    c1.col < c2.col && c1.row < c2.row
  end

  private def self.rectangle_valid?(ascii : Array(String), c1 : Coord, c2 : Coord) : Bool
    horizontal_line?(ascii, c1.row, c1.col, c2.col) &&
    horizontal_line?(ascii, c2.row, c1.col, c2.col) &&
    vertical_line?(ascii, c1.col, c1.row, c2.row) &&
    vertical_line?(ascii, c2.col, c1.row, c2.row)
  end

  private def self.horizontal_line?(ascii : Array(String), row : Int32, col_start : Int32, col_end : Int32) : Bool
    (col_start..col_end).all? { |col| ['+', '-'].includes? ascii[row][col] }
  end

  private def self.vertical_line?(ascii : Array(String), col : Int32, row_start : Int32, row_end : Int32) : Bool
    (row_start..row_end).all? { |row| ['+', '|'].includes? ascii[row][col] }
  end

  private def self.corners(ascii : Array(String)) : Array(Coord)
    ascii.map_with_index do |line, row|
      line.chars.map_with_index do |char, col|
        Coord.new(col, row) if char == '+'
      end.compact
    end.flatten
  end
end
