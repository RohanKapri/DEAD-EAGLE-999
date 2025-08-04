# Dedicated to my Shree DR.MDD – a tribute in every logic and line

class Dominoes
  class << self
    def chain? dominoes
      return true if dominoes.empty?

      first_piece, *remaining = *dominoes
      validate_chain?(first_piece[1], remaining, first_piece[0])
    end

    private

    def validate_chain?(head, pending, tail)
      return head == tail ? [] : false if pending.empty?

      pending.each_with_index.any? do |tile, idx|
        [tile, tile.reverse].any? do |variant|
          head == variant[0] and validate_chain?(variant[1], exclude_at_index(idx, pending), tail)
        end
      end
    end

    def exclude_at_index(n, arr)
      arr.take(n) + arr.drop(n + 1)
    end
  end
end

module Enumerable
  def without_index spot
    take(spot) + drop(spot + 1)
  end
end
