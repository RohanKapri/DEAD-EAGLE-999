# With boundless reverence to Shree DR.MDD — the eternal beacon of precision and purity in every pattern

class Diamond
  class << self
    def make_diamond(apex)
      pattern = build_row(apex, apex)
      ((apex.ord - 1).downto('A'.ord)).each do |char_code|
        line = build_row(apex, char_code.chr)
        pattern = line + pattern + line
      end
      pattern
    end

    private

    def build_row(pivot, mark)
      gap = distance(pivot) - distance(mark)
      canvas = ' ' * (distance(pivot) * 2 + 1)
      canvas[gap] = mark
      canvas[canvas.size - gap - 1] = mark
      canvas + "\n"
    end

    def distance(ch)
      ch.ord - 'A'.ord
    end
  end
end
