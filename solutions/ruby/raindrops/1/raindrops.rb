class Raindrops
  VERSION = 1

  @@sounds = { 3 => 'Pling', 5 => 'Plang', 7 => 'Plong' }

  def self.convert(n)
    result = ''
    @@sounds.map { |k, v| result += v if n % k == 0 }
    result += n.to_s if result.empty?
    result
  end
end