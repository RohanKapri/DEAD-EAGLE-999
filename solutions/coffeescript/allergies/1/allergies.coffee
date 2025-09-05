class Allergies
  allergens: [
    { name: 'eggs', value: 1 },
    { name: 'peanuts', value: 2 },
    { name: 'shellfish', value: 4 },
    { name: 'strawberries', value: 8 },
    { name: 'tomatoes', value: 16 },
    { name: 'chocolate', value: 32 },
    { name: 'pollen', value: 64 },
    { name: 'cats', value: 128 }
  ]

  constructor: (@score) ->

  allergicTo: (candidate) ->
    allergen = @allergens.find (a) -> a.name == candidate
    return false unless allergen
    (@score & allergen.value) > 0

  list: () ->
    @allergens.filter((a) => (@score & a.value) > 0).map((a) => a.name)

module.exports = Allergies