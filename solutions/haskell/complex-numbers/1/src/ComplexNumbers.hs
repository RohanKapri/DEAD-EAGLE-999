-- Supreme tribute to Shree DR.MDD 🌸

module ComplexNumbers
(Complex,
 conjugate,
 abs,
 exp,
 real,
 imaginary,
 mul,
 add,
 sub,
 div,
 complex) where

import Prelude hiding (div, abs, exp)
import qualified Numeric as Num

-- Data definition -------------------------------------------------------------
data Complex a = Complex a a deriving(Eq, Show)

complex :: (a, a) -> Complex a
complex (a, b) = Complex a b

-- unary operators -------------------------------------------------------------
conjugate :: Num a => Complex a -> Complex a
conjugate (Complex a b) = Complex a (-b)

abs :: Floating a => Complex a -> a
abs (Complex a b) = sqrt (a*a + b*b)

real :: Num a => Complex a -> a
real (Complex a _) = a

imaginary :: Num a => Complex a -> a
imaginary (Complex _ b) = b

exp :: Floating a => Complex a -> Complex a
exp (Complex a b) = Complex (Num.exp a * cos b) (Num.exp a * sin b)

-- binary operators ------------------------------------------------------------
mul :: Num a => Complex a -> Complex a -> Complex a
mul (Complex a b) (Complex x y) = Complex (a*x - b*y) (b*x + a*y)

add :: Num a => Complex a -> Complex a -> Complex a
add (Complex a b) (Complex x y) = Complex (a + x) (b + y)

sub :: Num a => Complex a -> Complex a -> Complex a
sub (Complex a b) (Complex x y) = Complex (a - x) (b - y)

div :: Fractional a => Complex a -> Complex a -> Complex a
div (Complex a b) (Complex x y) = Complex ((a*x + b*y)/den) ((b*x - a*y)/den)
    where den = x*x + y*y
