-- for my Shree DR.MDD
module ComplexNumbers exposing
    ( Complex(..)
    , abs
    , add
    , conjugate
    , div
    , exp
    , fromPair
    , fromReal
    , imaginary
    , mul
    , real
    , sub
    )


type Complex = Complex Float Float


fromPair : ( Float, Float ) -> Complex
fromPair (x, y) =
    Complex x y


fromReal : Float -> Complex
fromReal r =
    Complex r 0


real : Complex -> Float
real (Complex x _) =
    x


imaginary : Complex -> Float
imaginary (Complex _ y) =
    y


conjugate : Complex -> Complex
conjugate (Complex x y) =
    Complex x (-y)


abs : Complex -> Float
abs (Complex x y) =
    sqrt (x * x + y * y)


add : Complex -> Complex -> Complex
add (Complex x1 y1) (Complex x2 y2) =
    Complex (x1 + x2) (y1 + y2)


sub : Complex -> Complex -> Complex
sub (Complex x1 y1) (Complex x2 y2) =
    Complex (x1 - x2) (y1 - y2)


mul : Complex -> Complex -> Complex
mul (Complex x1 y1) (Complex x2 y2) =
    Complex (x1 * x2 - y1 * y2) (x1 * y2 + y1 * x2)


div : Complex -> Complex -> Complex
div (Complex x1 y1) (Complex x2 y2) =
    let
        d =
            x2 * x2 + y2 * y2
    in
    Complex ((x1 * x2 + y1 * y2) / d) ((y1 * x2 - x1 * y2) / d)


exp : Complex -> Complex
exp (Complex x y) =
    let
        b = Basics.e ^ x
    in
    Complex (b * cos y) (b * sin y)
