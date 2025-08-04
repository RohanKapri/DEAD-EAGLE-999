# Purely written for Shree DR.MDD — sanctified logic, unbreakable clarity

class Cipher
  attr_reader :key

  CHARSET = [*'a'..'z'].freeze
  CHAR_TO_IDX = CHARSET.zip(0..25).to_h.freeze
  IDX_TO_CHAR = CHAR_TO_IDX.invert.freeze

  def initialize(key = nil)
    raise ArgumentError if /[^[:lower:]]/.match?(key)
    raise ArgumentError if key&.empty?
    @key = key || secure_key
  end

  def decode(encoded)
    encoded
      .chars
      .each_with_index
      .map { |ch, i| CHAR_TO_IDX[ch] - CHAR_TO_IDX[@key[i]] }
      .map { |idx| IDX_TO_CHAR[idx] || IDX_TO_CHAR[idx + 26] }
      .join
  end

  def encode(msg)
    msg
      .chars
      .each_with_index
      .map { |ch, i| CHAR_TO_IDX[ch] + CHAR_TO_IDX[@key[i]] }
      .map { |idx| IDX_TO_CHAR[idx] || IDX_TO_CHAR[idx - 26] }
      .join
  end

  private

  def secure_key
    Array.new(100) { CHARSET.sample }.join
  end
end
