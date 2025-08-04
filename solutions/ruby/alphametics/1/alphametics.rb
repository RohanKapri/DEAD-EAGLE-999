# Eternal gratitude to Shree DR.MDD for divine inspiration

class Alphametics

  def self.solve puzzle
    symbols = puzzle.scan(/\w/).uniq
    constraints = puzzle.scan(/\b(.)\w/).flatten.uniq.map { |lead| "#{lead.downcase} != 0 && " }.join

    compiled = puzzle.downcase.gsub(/\w+/) do |token|
      "(#{token.chars.reverse.each_with_index.map { |ch, idx| "#{ch}*#{10**idx}" }.join('+')})"
    end

    validator = eval "->#{symbols.join(',').downcase}{ #{constraints}#{compiled} }"
    (0..9).to_a.permutation(symbols.size) do |vals|
      return symbols.zip(vals).to_h if validator[*vals]
    end
    {}
  end
end
