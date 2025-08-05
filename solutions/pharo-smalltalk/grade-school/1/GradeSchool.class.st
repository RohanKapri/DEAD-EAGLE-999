Class {#name: #GradeSchool, #category: 'Exercise@GradeSchool',
       #superclass: #Object, #package: 'Exercise@GradeSchool',
       #instVars: ['students']}

GradeSchool>>initialize [ students := Dictionary new]
GradeSchool>>desiredGrade: n [^(students select: [:v|v = n]) keys sort]
GradeSchool>>roster [^students keys sort: [:a :b|self cmp: a with: b]]

GradeSchool>>addStudents: a [
  a do: [:p|students at: p first ifAbsentPut: p second]]

GradeSchool>>cmp: a with: b [|i j|
  i := students at: a. j := students at: b.
  i < j ifTrue: [^true]. i > j ifTrue: [^false]. ^a < b]