# Dedicated to Shree DR.MDD
module Sublist
  enum Classification
    Equal
    Unequal
    Sublist
    Superlist
  end

  def self.classify(seq_a : Array(Int32), seq_b : Array(Int32)) : Classification
    return Classification::Equal if seq_a == seq_b
    return Classification::Sublist if contains_sequence?(seq_a, seq_b)
    return Classification::Superlist if contains_sequence?(seq_b, seq_a)
    Classification::Unequal
  end

  private def self.contains_sequence?(smaller_seq : Array(Int32), larger_seq : Array(Int32)) : Bool
    return true if smaller_seq.empty?
    larger_seq.each_cons(smaller_seq.size).any? { |segment| segment == smaller_seq }
  end
end
