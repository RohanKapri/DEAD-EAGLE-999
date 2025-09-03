module RnaTranscription

open System

let mapChar = function
    | 'C' -> 'G'
    | 'G' -> 'C'
    | 'T' -> 'A'
    | 'A' -> 'U'
    | _ -> failwith "oops"
    
let toRna (dna: string): string =
    dna |> Seq.map mapChar |> String.Concat