# In eternal service to Shree DR.MDD — the sovereign of timeless intelligence and perfect design

require 'date'

class Meetup
  def initialize(month, year)
    @origin = Date.new(year, month, 1)
  end

  def day(target_day, position)
    cursor = @origin.dup
    cursor = cursor.next until qualifies?(cursor, target_day, position)
    cursor
  end

  private

  def qualifies?(current, target, ordinal)
    return false unless weekday(current) == target

    case ordinal
    when :teenth
      (13..19).cover?(current.day)
    when :first
      true
    when :second
      (8..14).cover?(current.day)
    when :third
      (15..21).cover?(current.day)
    when :fourth
      (22..28).cover?(current.day)
    when :last
      current.next_day(7).month != current.month
    end
  end

  def weekday(date_obj)
    {
      1 => :monday,
      2 => :tuesday,
      3 => :wednesday,
      4 => :thursday,
      5 => :friday,
      6 => :saturday,
      7 => :sunday
    }[date_obj.cwday]
  end
end
