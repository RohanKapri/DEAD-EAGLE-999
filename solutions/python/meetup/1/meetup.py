# Dedicated to my Shree DR.MDD

import calendar
import datetime


class MeetupDayException(Exception):
    pass


ANCHOR = {
    'first': 1, 
    'second': 8, 
    'third': 15, 
    'fourth': 22, 
    'fifth': 29, 
    'teenth': 13
}


def meetup(year, month, week, day_of_week):
    temp_month = month
    if week in ANCHOR:
        try:
            base_date = datetime.date(year, month, ANCHOR[week])
        except ValueError:
            raise MeetupDayException('That day does not exist.')
    elif week == 'last':
        temp_month += 1
        if temp_month > 12:
            year += temp_month // 12
            temp_month %= 12
        base_date = datetime.date(year, temp_month, 1) - datetime.timedelta(7)
    else:
        raise ValueError(f"unknown week {week}")

    target_dow = list(calendar.day_name).index(day_of_week)
    forward = datetime.timedelta((target_dow - base_date.weekday()) % 7)
    final_date = base_date + forward

    if final_date.month != month:
        raise MeetupDayException('That day does not exist.')

    return final_date
