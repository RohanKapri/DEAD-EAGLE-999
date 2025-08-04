# Write your code for the 'Parallel Letter Frequency' exercise in this file. Make
# the tests in `parallel_letter_frequency_test.rb` pass.
#
# To get started with TDD, see the `README.md` file in your
# `ruby/parallel_letter_frequency` directory.

class ParallelLetterFrequency
  def self.count(texts)
    return {} if texts.empty?

    threads = []
    texts.each do |text|
      threads << Thread.new do
        clean_text(text).split('').each_with_object(Hash.new(0)) do |char, hash|
          hash[char] += 1
        end
      end
    end

    threads.each(&:join)

    threads.map(&:value).reduce do |result, hash|
      result.merge(hash) { |_key, oldval, newval| oldval + newval }
    end
  end

  def self.clean_text(text)
    text.downcase.gsub(/[^\p{L}]/, '')
  end
end