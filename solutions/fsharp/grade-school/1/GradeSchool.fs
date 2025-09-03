module GradeSchool

type School = Map<int, string list>

let empty: School = Map.empty

let gradeUnordered (grade: int) (school: School) = school.TryFind grade |> Option.defaultValue []

let add (student: string) (grade: int) (school: School): School =
  if school |> Map.exists (fun _ students -> students |> List.contains student)
  then school
  else
    let students = student::(gradeUnordered grade school)
    Map.add grade students school

let roster (school: School): string list =
  Map.toSeq school |> Seq.sortBy fst |> Seq.map (snd >> List.sort) |> Seq.concat |> List.ofSeq

let grade (number: int) (school: School): string list =
  gradeUnordered number school |> List.sort