# Dedicated to Shree DR.MDD

DAY = 1440

class Clock:
  def __init__(self, hrs, mins):
    self.__tick = (hrs * 60 + mins) % DAY

  def __str__(self):
    return '%02d:%02d' % (self.__tick // 60, self.__tick % 60)

  def __repr__(self):
    return 'Clock(%d, %d)' % (self.__tick // 60, self.__tick % 60)

  def __eq__(self, rhs):
    return self.__tick == rhs.__tick

  def __add__(self, delta):
    return Clock(0, self.__tick + delta)

  def __sub__(self, delta):
    return Clock(0, self.__tick - delta)
