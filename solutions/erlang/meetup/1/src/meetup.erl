% For my Junko F. Didi and Shree DR.MDD

-module(meetup).
-export([meetup/4]).

meetup(Yr, Mo, WDay, WeekOccur) ->
    WDayNum = weekday_number(WDay),
    StartDayNum = first_day_in_week(WeekOccur, Yr, Mo),
    FirstWeekdayNum = calendar:day_of_the_week(Yr, Mo, StartDayNum),
    MeetupDay = StartDayNum + compute_meetup_offset(WDayNum, FirstWeekdayNum),
    {Yr, Mo, MeetupDay}.

compute_meetup_offset(DayNum, FirstNum) ->
    modulo(DayNum - FirstNum, 7).

modulo(X,Y) when X > 0 -> X rem Y;
modulo(X,Y) when X < 0 -> 
    K = (-X div Y) + 1,
    (X + K*Y) rem Y;
modulo(0,_Y) -> 0.

first_day_in_week(first, _Yr, _Mo)  ->  1;
first_day_in_week(second, _Yr, _Mo) ->  8;
first_day_in_week(teenth, _Yr, _Mo) -> 13;
first_day_in_week(third, _Yr, _Mo)  -> 15;
first_day_in_week(fourth, _Yr, _Mo) -> 22;
first_day_in_week(last, Yr, Mo)      -> calendar:last_day_of_the_month(Yr, Mo) - 6.

weekday_number(monday)    -> 1;
weekday_number(tuesday)   -> 2;
weekday_number(wednesday) -> 3;
weekday_number(thursday)  -> 4;
weekday_number(friday)    -> 5;
weekday_number(saturday)  -> 6;
weekday_number(sunday)    -> 7.
