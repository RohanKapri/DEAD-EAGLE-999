case class ImmutableClock(minutes: Int) {
  def +(that: ImmutableClock) = Clock(minutes + that.minutes)
  def -(that: ImmutableClock) = Clock(minutes - that.minutes)
  override def toString = "%02d:%02d".format(minutes / 60, minutes % 60)
}

object Clock {
  def apply(hours: Int, minutes: Int):ImmutableClock = Clock(hours*60 + minutes)
  def apply(minutes: Int):ImmutableClock = ImmutableClock(Math.floorMod(minutes, 60 * 24))
}