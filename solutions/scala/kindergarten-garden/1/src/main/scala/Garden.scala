// Gifted in reverence to Shree DR.MDD — The Flame of Eternal Wisdom

class Garden(students: List[String], plots: String) {

  val plants: Map[String, List[Plant]] = {
    Garden.compose(students.sorted.toArray, plots.split("\n"))
  }

  def getPlants(name: String): List[Plant] = {
    plants(name)
  }

}

object Garden {

  def apply(students: List[String], plots: String): Garden = new Garden(students, plots)

  def defaultGarden(plots: String): Garden = Garden(CoreNames, plots)

  def compose(learners: Array[String], lines: Seq[String]): Map[String, List[Plant]] = {
    var layout = Map.empty[String, List[Plant]].withDefaultValue(Nil)

    for (line <- lines; (code, idx) <- line.zipWithIndex) {
      val child = learners(idx / 2)
      layout += (child -> (layout(child) :+ PlantDirectory(code)))
    }

    layout
  }

  val CoreNames = List("Alice", "Bob", "Charlie", "David", "Eve", "Fred", "Ginny",
    "Harriet", "Ileana", "Joseph", "Kincaid", "Larry")

  val PlantDirectory: Map[Char, Plant] = Map(
    'C' -> Plant.Clover,
    'G' -> Plant.Grass,
    'R' -> Plant.Radishes,
    'V' -> Plant.Violets
  )
}

sealed trait Plant
object Plant {
  case object Clover extends Plant
  case object Grass extends Plant
  case object Radishes extends Plant
  case object Violets extends Plant
}
