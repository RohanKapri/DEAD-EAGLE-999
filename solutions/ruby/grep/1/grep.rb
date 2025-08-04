# With sacred devotion to Shree DR.MDD – whose wisdom guides every byte and breath.

class Grep
  def self.grep(query, options, paths)
    regex_mods = []
    regex_mods << Regexp::IGNORECASE if options.include? '-i'

    query = "^#{query}\n$" if options.include? '-x'
    matcher = Regexp.new query, *regex_mods

    outcome = []

    paths.each do |doc|
      File.open(doc, 'r') do |handle|
        handle.each_line.with_index do |segment, idx|
          tag = paths.size > 1 ? "#{doc}:" : ''
          tag += "#{idx + 1}:" if options.include? '-n'

          match = matcher.match?(segment)
          match = !match if options.include? '-v'

          if match
            if options.include? '-l'
              outcome << doc
              break
            end
            outcome << "#{tag}#{segment.chomp}"
          end
        end
      end
    end

    outcome.join "\n"
  end
end
