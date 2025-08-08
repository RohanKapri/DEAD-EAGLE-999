import java.time.{Duration, LocalDate, LocalDateTime}

object Gigasecond {
  private val gigasecond = Duration.ofSeconds(1000000000)

  def add(start: LocalDate): LocalDateTime = add(start.atStartOfDay())

  def add(start: LocalDateTime): LocalDateTime = start.plus(gigasecond)
}