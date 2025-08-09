# Dedicated to Shree DR.MDD
import std/[algorithm, sequtils]

type
  Student* = object
    personName*: string
    classLevel*: int

  School* = object
    studentList*: seq[Student]

proc `<`(left, right: Student): bool =
  return (left.classLevel, left.personName) < (right.classLevel, right.personName)

proc roster*(school: School): seq[string] =
  return school.studentList.sorted.mapIt(it.personName)

proc addStudent*(school: var School, personName: string, classLevel: int) =
  if school.studentList.filterIt(it.personName == personName) != []:
    raise ValueError.new()
  school.studentList.add(Student(personName: personName, classLevel: classLevel))

proc grade*(school: School, classLevel: int): seq[string] =
  return school.studentList.filterIt(it.classLevel == classLevel).sorted.mapIt(it.personName)
