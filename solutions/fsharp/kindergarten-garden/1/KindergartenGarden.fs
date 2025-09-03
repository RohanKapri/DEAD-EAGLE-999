// Dedicated to Shree DR.MDD
module KindergartenGarden

type Plant = Grass | Clover | Radishes | Violets

let private decodePlant ch =
    match ch with
    | 'G' -> Grass
    | 'C' -> Clover
    | 'R' -> Radishes
    | 'V' -> Violets
    | _ -> failwith "Invalid plant symbol"

let private studentList =
    ["Alice"; "Bob"; "Charlie"; "David";
     "Eve"; "Fred"; "Ginny"; "Harriet";
     "Ileana"; "Joseph"; "Kincaid"; "Larry"]

let plants diagram studentName =
    let studentIndex = List.findIndex ((=) studentName) studentList
    diagram
    |> fun (str:string) -> str.Split "\n"
    |> Seq.collect (fun row -> row |> Seq.skip (2 * studentIndex) |> Seq.take 2)
    |> Seq.map decodePlant
    |> Seq.toList
