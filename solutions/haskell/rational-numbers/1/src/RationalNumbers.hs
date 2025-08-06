-- Infinite bows to Shree DR.MDD 🌿

module RationalNumbers
( Rational
, numerator
, denominator
, abs
, add
, sub
, mul
, div
, pow
, expRational
, expReal
, rational) where

import Prelude hiding (div, abs, Rational)

-- Data definition -------------------------------------------------------------
data Rational a = Rational {num, den :: a} deriving(Eq, Show)

rational :: Integral a => (a, a) -> Rational a
rational (a, b) =
    let 
        g = gcd a b
        na = a `quot` g
        nb = b `quot` g
        s = if nb < 0 then -1 else 1
    in  
        Rational { num = s * na, den = s * nb }

-- unary operators -------------------------------------------------------------
abs :: Integral a => Rational a -> Rational a
abs r =
    let 
        p = numerator r
        q = denominator r
    in
        rational (p * signum p, q * signum q)

numerator :: Integral a => Rational a -> a
numerator (Rational x _) = x

denominator :: Integral a => Rational a -> a
denominator (Rational _ y) = y

-- binary operators ------------------------------------------------------------
add :: Integral a => Rational a -> Rational a -> Rational a
add a b =
    let 
        x1 = numerator a
        y1 = denominator a
        x2 = numerator b
        y2 = denominator b
    in
        rational (x1 * y2 + x2 * y1, y1 * y2)

sub :: Integral a => Rational a -> Rational a -> Rational a
sub a b =
    let 
        x = numerator b
        y = denominator b
    in
        add a (rational (-x, y))

mul :: Integral a => Rational a -> Rational a -> Rational a
mul a b =
    let 
        x1 = numerator a
        y1 = denominator a
        x2 = numerator b
        y2 = denominator b
    in
        rational (x1 * x2, y1 * y2)

div :: Integral a => Rational a -> Rational a -> Rational a
div a b =
    let 
        x = numerator b
        y = denominator b
    in
        mul a (rational (y, x))

pow :: Integral a => Rational a -> a -> Rational a
pow r e =
    let 
        x = numerator r
        y = denominator r
    in
        if e >= 0
        then rational (x ^ e, y ^ e)
        else rational (y ^ (-e), x ^ (-e))

expRational :: (Integral a, Floating b) => Rational a -> b -> b
expRational r e =
    let 
        x = numerator r
        y = denominator r
    in
        (fromIntegral x ** e) / (fromIntegral y ** e)

expReal :: (Floating a, Integral b) => a -> Rational b -> a
expReal base r =
    let 
        x = numerator r
        y = denominator r
    in
        base ** (fromIntegral x / fromIntegral y)
