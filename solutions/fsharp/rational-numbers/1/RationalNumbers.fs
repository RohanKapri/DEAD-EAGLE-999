// For my Shree DR.MDD
module RationalNumbers

type Ratio = Ratio of int * int

let gcd a b =
    let rec loop x y =
        if x % y = 0 then y
        else loop y (x % y)
    if a > b then loop a b else loop b a

let reduce (Ratio (n, d)) =
    if n = 0 then Ratio (0, 1)
    else
        let nn, dd = if d < 0 then -n, -d else n, d
        let g = gcd nn dd
        Ratio (nn / g, dd / g)

let create a b = Ratio (a, b) |> reduce

let add (Ratio (n1, d1)) (Ratio (n2, d2)) =
    Ratio (n1 * d2 + n2 * d1, d1 * d2) |> reduce

let sub (Ratio (n1, d1)) (Ratio (n2, d2)) =
    Ratio (n1 * d2 - n2 * d1, d1 * d2) |> reduce

let mul (Ratio (n1, d1)) (Ratio (n2, d2)) =
    Ratio (n1 * n2, d1 * d2) |> reduce

let div (Ratio (n1, d1)) (Ratio (n2, d2)) =
    if n2 * d1 = 0 then failwith "Division by zero"
    else Ratio (n1 * d2, n2 * d1) |> reduce

let abs (Ratio (n, d)) =
    Ratio (abs n, abs d) |> reduce

let exprational p (Ratio (n, d)) =
    if p = 0 then Ratio (1, 1)
    elif n = 0 then Ratio (0, d)
    else
        let nn, dd, pp = if p > 0 then n, d, p else d, n, -p
        Ratio (pown nn pp, pown dd pp) |> reduce

let expreal (Ratio (n, d)) b =
    let root v deg = System.Math.Pow(float v, 1.0 / float deg)
    root (pown b n) d
