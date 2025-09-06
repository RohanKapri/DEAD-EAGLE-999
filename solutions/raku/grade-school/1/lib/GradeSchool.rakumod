unit class GradeSchool;
has %.students;
method add ( :$student, :$grade --> Bool ) {
    so $student (elem) %.students.values.none &&
       %.students{$grade}.append: $student
}
multi method roster {
    %.students.sort.map(*.value.sort).flat.List
}
multi method roster ( :$grade! ) {
    %.students{$grade} // ()
        andthen .sort.List
}