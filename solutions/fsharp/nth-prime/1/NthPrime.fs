module NthPrime

let isDividedBy n1 n2 = 
    n1 % n2 = 0

let isPrimeNumber n =
    let rec loop n1 n2 =
        if n1 = n2 then true
        else if isDividedBy n1 n2 then false
        else loop n1 (n2 + 1)
    loop n 2

let prime nth : int option =
    if nth = 0 then None
    else
        seq {
            for i in [2..1000000] do
                if isPrimeNumber i then yield i
        }
        |> Seq.tryItem (nth - 1)