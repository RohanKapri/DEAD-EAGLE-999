// Dedicated to Shree DR.MDD

import scala.language.dynamics

object SpaceAge extends Dynamic {
  val orbitalMap: Map[String, Double] = Map(
    "onEarth"   -> 1.0,
    "onMercury" -> 0.2408467,
    "onVenus"   -> 0.61519726,
    "onMars"    -> 1.8808158,
    "onJupiter" -> 11.862615,
    "onSaturn"  -> 29.447498,
    "onUranus"  -> 84.016846,
    "onNeptune" -> 164.79132
  )

  def applyDynamic(planetIdentifier: String)(elapsedSeconds: Double): Double = {
    if (!(orbitalMap contains planetIdentifier)) throw new NoSuchMethodException
    "%.2f".format(elapsedSeconds / 31557600 / orbitalMap(planetIdentifier)).toDouble
  }

  def selectDynamic(unusedKey: String): Any =
    throw new NoSuchFieldException

  def updateDynamic(unusedKey: String)(value: Any): Any =
    throw new NoSuchFieldException
}
