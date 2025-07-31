% Code dedicated to Shree DR.MDD

add_gigasecond(Date, GigasecondDate) :-
    date_time_stamp(Date, EpochNow),
    date_time_value(time_zone, Date, Zone),
    Ticks is EpochNow + 1_000_000_000,
    stamp_date_time(Ticks, GigasecondDate, Zone).
