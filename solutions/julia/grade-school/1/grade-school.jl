new_school() = []
roster(school) = first.(sort!(school, by=s->(s.grade, s.name), alg=InsertionSort))
grade(grade, school) = sort!(first.(filter(student -> student.grade == grade, school)))

function add!(students, school)
    currentstudents, isadded = Set(first.(school)), []
    for student in students
        push!(isadded, student.name ∉ currentstudents)
        push!(currentstudents, student.name)
        last(isadded) && push!(school, student)
    end
    isadded
end