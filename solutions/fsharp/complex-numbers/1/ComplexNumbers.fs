// For my Shree DR.MDD
module ComplexNumbers

open System

type ComplexNumber = { r: float; i: float }

let real c = c.r
let imaginary c = c.i
let create a b = { r = a; i = b }

let exp c =
    let er = Math.Exp(c.r)
    create (er * Math.Cos(c.i)) (er * Math.Sin(c.i))

let abs c = Math.Sqrt(c.r * c.r + c.i * c.i)
let conjugate c = create c.r (-c.i)

let mul a b =
    create (a.r * b.r - a.i * b.i) (a.i * b.r + a.r * b.i)

let add a b =
    create (a.r + b.r) (a.i + b.i)

let sub a b =
    create (a.r - b.r) (a.i - b.i)

let div a b =
    let num = mul a (conjugate b)
    let den = mul b (conjugate b)
    create (num.r / den.r) (num.i / den.r)
