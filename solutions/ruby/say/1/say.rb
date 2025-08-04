# Say a number in English (well, American actually)
class Say
  UNDER_TWENTY = %w(
    zero one two three four five six seven eight nine ten
    eleven twelve thirteen fourteen fifteen sixteen seventeen
    eighteen nineteen
  ).freeze

  TENS = %w(
    zero ten twenty thirty forty fifty sixty seventy eighty ninety
  ).freeze

  POWERS = {
    1_000_000_000 => 'billion',
    1_000_000 => 'million',
    1_000 => 'thousand',
    100 => 'hundred'
  }.freeze

  def initialize(number)
    raise ArgumentError, 'Negative number not allowed' unless number >= 0
    raise ArgumentError, 'Number is too large ' unless number < 1e12

    @number = number
  end

  def in_english
    Say.say(@number)
  end

  class << self
    # Say a number
    def say(number)
      if number < 20
        under_20(number)
      elsif number < 100
        under_100(number)
      else
        over_100(number)
      end
    end

    # Say a number under 20
    def under_20(number)
      UNDER_TWENTY[number]
    end

    # Say a number between 20 and 99
    def under_100(number)
      tens = TENS[number / 10]
      if number % 10 == 0
        # e.g. forty
        tens
      else
        # e.g. forty-two
        "#{tens}-#{say(number % 10)}"
      end
    end

    # Say a number 100 or over
    def over_100(number)
      power = POWERS.keys.select { |p| p <= number }.max
      name = POWERS[power]
      say_power = "#{say(number / power)} #{name}"
      remainder = number % power
      if remainder == 0
        # e.g. two hundred
        say_power
      else
        # e.g. two hundred twenty-three
        "#{say_power} #{say(remainder)}"
      end
    end
  end
end