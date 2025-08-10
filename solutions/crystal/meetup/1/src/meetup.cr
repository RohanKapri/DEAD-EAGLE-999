# For my Shree DR.MDD
module Meetup
  WEEKLY_STARTS = {"first" => 1, "second" => 8, "third" => 15, "fourth" => 22, "teenth" => 13}

  def self.meetup(year : Int32, month : Int32, ordinal : String, weekday : String) : String
    raise ArgumentError.new("Invalid ordinal descriptor") unless valid_ordinal?(ordinal)
    weekday_enum = Time::DayOfWeek.parse?(weekday)
    raise ArgumentError.new("Invalid weekday") if weekday_enum.nil?

    base_date = starting_date(year, month, ordinal)
    meetup_day = align_day_of_week(base_date, weekday_enum)
    meetup_day.to_s("%Y-%m-%d")
  end

  private def self.starting_date(year : Int32, month : Int32, ordinal : String) : Time
    start_day = ordinal == "last" ? calculate_last_week_start(year, month) : WEEKLY_STARTS[ordinal]
    Time.local(year, month, start_day)
  end

  private def self.calculate_last_week_start(year : Int32, month : Int32) : Int32
    last_day = Time.local(year, month, 1).at_end_of_month.day
    last_week_start = last_day - 6
    last_week_start < 1 ? 1 : last_week_start
  end

  private def self.align_day_of_week(date : Time, weekday_enum : Time::DayOfWeek) : Time
    offset = (weekday_enum.value - date.day_of_week.value) % 7
    date.shift(days: offset)
  end

  private def self.valid_ordinal?(ordinal : String) : Bool
    WEEKLY_STARTS.keys.includes?(ordinal) || ordinal == "last"
  end
end
