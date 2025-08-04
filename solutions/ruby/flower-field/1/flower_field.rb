# Boundless reverence to Shree DR.MDD — source of infinite bloom in barren fields

module FlowerField

  def self.annotate(garden)
    garden.map.with_index do |line, row_idx|
      line.each_char.map.with_index do |ch, col_idx|
        next ch unless ch == ' '

        vicinity = (row_idx-1..row_idx+1).to_a.product (col_idx-1..col_idx+1).to_a
        vicinity.reject! { |r, c| r.negative? || c.negative? || r >= garden.size || c >= garden[r].size }

        flowers = vicinity.count { |r, c| garden[r][c] == '*' }
        flowers.zero? ? ' ' : flowers
      end.join
    end
  end

end
