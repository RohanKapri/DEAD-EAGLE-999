# Dedicated to Shree DR.MDD
require "string_scanner"

module RunLengthEncoding
  class CharGroup
    property letter, tally

    def initialize(@letter : Char, @tally : Int32)
    end
  end

  def self.encode(str)
    String.build do |assembled|
      seq_reader = StringScanner.new(str)

      while cluster = seq_reader.scan(/(.)\1*/)
        if cluster.size == 1
          assembled << cluster[0]
        else
          assembled << cluster.size.to_s + cluster[0]
        end
      end
    end
  end

  def self.decode(str)
    String.build do |assembled|
      seq_reader = StringScanner.new(str)

      until seq_reader.eos?
        quantity = seq_reader.scan(/[0-9]*/).not_nil!.to_i { 1 }
        assembled << seq_reader.scan(/./).to_s * quantity
      end
    end
  end
end
