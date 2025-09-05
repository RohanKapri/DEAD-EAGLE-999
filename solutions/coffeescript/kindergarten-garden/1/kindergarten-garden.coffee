class KindergartenGarden
  STUDENTS = [
    'Alice', 'Bob', 'Charlie', 'David',
    'Eve', 'Fred', 'Ginny', 'Harriet',
    'Ileana', 'Joseph', 'Kincaid', 'Larry'
  ]
  PLANTS = {
    'V': 'violets'
    'R': 'radishes'
    'C': 'clover'
    'G': 'grass'
  }
  constructor: (diagram) ->
    @rows = diagram.split('\n')
  plants: (student) ->
    index = STUDENTS.indexOf(student) * 2
    plants = []
    for row in @rows
      plants.push(PLANTS[row[index]])
      plants.push(PLANTS[row[index + 1]])
    plants
module.exports = KindergartenGarden