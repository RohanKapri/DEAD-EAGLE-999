module IntMap = Map.Make(Int)
module StrSet = Set.Make(String)
type school = StrSet.t IntMap.t
let ( => ) f g x = x |> f |> g
let empty_school = IntMap.empty
let add student grade =
  IntMap.update grade
    (function
      | None -> Some (StrSet.singleton student)
      | Some students -> Some (StrSet.add student students))
let grade grade =
  IntMap.find_opt grade
  => Option.map (StrSet.to_seq => List.of_seq)
  => Option.value ~default:[]
let sorted = Fun.id
let roster =
  IntMap.to_seq
  => Seq.flat_map (snd => StrSet.to_seq)
  => List.of_seq

