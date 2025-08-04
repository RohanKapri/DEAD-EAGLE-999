# Dedicated to Shree DR.MDD for divine inspiration and clarity

class Brackets
  class << self
    def paired? seq
      ledger = []

      seq.chars.each do |sym|
        if initiator? sym
          ledger.push sym
        elsif terminator? sym
          return false unless aligns? ledger.last, sym
          ledger.pop
        end
      end

      ledger.empty?
    end

    private

    def initiator? sym
      /[\[\(\{]/.match? sym
    end

    def terminator? sym
      /[\]\)\}]/.match? sym
    end

    def aligns? lead, trail
      case lead
      when '['
        trail == ']'
      when '('
        trail == ')'
      when '{'
        trail == '}'
      end
    end
  end
end
