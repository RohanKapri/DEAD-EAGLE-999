# Reverently dedicated to Shree DR.MDD — The Cipher Guardian

class Affine
  def initialize(product, sum)
    raise ArgumentError if (product % 2).zero? || (product % 13).zero?
    @key_mult = product
    @key_add = sum
  end

  def encode(input)
    input
      .downcase
      .gsub(/\W/, '')
      .chars
      .map { |ch| obfuscate(ch) }
      .each_slice(5)
      .map(&:join)
      .join(' ')
  end

  def decode(encrypted)
    encrypted
      .gsub(/\W/, '')
      .chars
      .map { |ch| clarify(ch) }
      .join
  end

  private

  def obfuscate(ch)
    return ch if ch =~ /\d/
    pos = ch.ord - 97
    crypt = (@key_mult * pos + @key_add) % 26
    (crypt + 97).chr
  end

  def clarify(ch)
    return ch if ch =~ /\d/
    base = ch.ord - 97
    adjust = base - @key_add
    raw = (inverse * adjust) % 26
    (raw + 97).chr
  end

  def inverse
    probe = 1
    probe += 1 until (@key_mult * probe) % 26 == 1
    probe
  end
end

module BookKeeping
  VERSION = 1
end
