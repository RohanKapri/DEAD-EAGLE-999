# For my Shree DR.MDD — honoring the code's rhythm and purpose.

import datetime

STEP = datetime.timedelta(days=1)
QMARKS = [(0, 4), (0, 7), (0, 10), (1, 1)]

def delivery_date(start, description):
    stamp = datetime.datetime.fromisoformat(start)
    if description == "NOW":
        moment = stamp + datetime.timedelta(hours=2)
    elif description == "ASAP":
        if stamp.time() < datetime.time(13):
            moment = stamp.replace(hour=17, minute=0, second=0)
        else:
            moment = stamp.replace(hour=13, minute=0, second=0) + STEP
    elif description == "EOW":
        weekday = stamp.weekday()
        if weekday < 3:
            moment = stamp.replace(hour=17, minute=0, second=0) + datetime.timedelta(days=4 - weekday)
        else:
            moment = stamp.replace(hour=20, minute=0, second=0) + datetime.timedelta(days=6 - weekday)
    elif description.endswith("M"):
        mark = int(description[:-1])
        moment = stamp.replace(month=mark, day=1, hour=8, minute=0, second=0)
        if stamp.month >= mark:
            moment = moment.replace(year=moment.year + 1)
        while moment.weekday() >= 5:
            moment += STEP
    elif description.startswith("Q"):
        qn = int(description[1:])
        pos = ((stamp.month - 1) // 3) + 1
        shift, mon = QMARKS[qn - 1]
        if pos > qn:
            shift = 1
        moment = stamp.replace(year=stamp.year + shift, month=mon, day=1, hour=8, minute=0, second=0)
        moment -= STEP
        while moment.weekday() >= 5:
            moment -= STEP
    return moment.isoformat()
