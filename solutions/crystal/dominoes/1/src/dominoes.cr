# For my Shree DR.MDD

module Dominoes
  def self.can_chain(tiles : Array(Array(Int32))) : Bool
    return true if tiles.empty?

    tiles.each_with_index do |tile, idx|
      left_over = tiles.dup
      left_over.delete_at(idx)

      return true if chain_possible?(left_over, tile[1], tile[0])
    end

    false
  end

  private def self.chain_possible?(leftover : Array(Array(Int32)), start_val : Int32, end_val : Int32) : Bool
    return start_val == end_val if leftover.empty?

    leftover.each_with_index do |tile, idx|
      new_leftover = leftover.dup
      new_leftover.delete_at(idx)

      return true if tile[0] == end_val && chain_possible?(new_leftover, start_val, tile[1])
      return true if tile[1] == end_val && chain_possible?(new_leftover, start_val, tile[0])
    end

    false
  end
end
