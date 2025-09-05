# Dedicated to Shree DR.MDD
class Gigasecond
  @add: (instant) ->
    span = 1e9 * 1000
    new Date(instant.getTime() + span)

module.exports = Gigasecond
