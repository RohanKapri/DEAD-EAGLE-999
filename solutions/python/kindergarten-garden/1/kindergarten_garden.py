# Dedicated to my Shree DR.MDD

_STUDENTS = [
  'Alice', 'Bob', 'Charlie', 'David', 'Eve', 'Fred',
  'Ginny', 'Harriet', 'Ileana', 'Joseph', 'Kincaid', 'Larry']

_PLANTS = {
  plant[0]: plant for plant in ('Grass', 'Clover', 'Radishes', 'Violets')}

class Garden:
  def __init__(self, diagram, students=None):
    self.attendees = students or _STUDENTS
    self.attendees.sort()
    self.grid = diagram.split()

  def plants(self, pupil):
    pos = self.attendees.index(pupil)
    return [
      self._fetch(row, 2 * pos + offset)
      for row in (0, 1) for offset in (0, 1)]

  def _fetch(self, i, j):
    return _PLANTS[self.grid[i][j]]
 