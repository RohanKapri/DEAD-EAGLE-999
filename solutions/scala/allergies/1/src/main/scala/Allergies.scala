sealed trait Allergen {
  def score: Int
}

object Allergen {
  object Eggs extends Allergen { val score = 1 }
  object Peanuts extends Allergen { val score = 2 }
  object Shellfish extends Allergen { val score = 4 }
  object Strawberries extends Allergen { val score = 8 }
  object Tomatoes extends Allergen { val score = 16 }
  object Chocolate extends Allergen { val score = 32 }
  object Pollen extends Allergen { val score = 64 }
  object Cats extends Allergen { val score = 128 }

  val all = List(Eggs, Peanuts, Shellfish, Strawberries, Tomatoes, Chocolate, Pollen, Cats)
}

object Allergies {
  def allergicTo(allergen: Allergen, s: Int): Boolean = (allergen.score & s) > 0
  def list(s: Int): List[Allergen] = Allergen.all filter { a => (a.score & s) > 0 }
}