type
  Allergen* = enum
    Eggs
    Peanuts
    Shellfish
    Strawberries
    Tomatoes
    Chocolate
    Pollen
    Cats

  Allergens = set[Allergen]


func allergies*(n: int): Allergens =
  cast[Allergens](n)

func isAllergicTo*(n: int, allergen: Allergen): bool =
  allergen in allergies(n)