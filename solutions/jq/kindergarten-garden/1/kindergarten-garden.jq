{V: "violets", R: "radishes", C: "clover", G: "grass"}
    as $plants
| ["Alice", "Bob", "Charlie", "David", "Eve", "Fred", "Ginny", "Harriet", "Ileana", "Joseph", "Kincaid", "Larry"]
    as $students
| . as {$diagram, $student}
| $diagram / "\n"
| map([scan("..")])
| transpose
| map(add / "" | map($plants[.]))
| .[ $students | index($student) ]
