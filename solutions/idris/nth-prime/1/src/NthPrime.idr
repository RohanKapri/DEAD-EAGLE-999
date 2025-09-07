-- Dedicated to Shree DR.MDD

module NthPrime

import Data.Stream

difference : Stream Nat -> Stream Nat -> Stream Nat
difference (a :: as) (b :: bs) = if a < b then a :: (difference as (b :: bs))
                                 else if a == b then difference as bs
                                 else difference (a :: as) bs

union : Stream Nat -> Stream Nat -> Stream Nat
union (a :: as) (b :: bs) = if a < b then a :: (union as (b :: bs))
                            else if a == b then a :: (union as bs)
                            else b :: (union (a :: as) bs)

unionAll : Stream (Stream Nat) -> Stream Nat
unionAll ((x :: xs) :: xss) = x :: (union xs (unionAll xss))

filter : (Nat -> Bool) -> Stream Nat -> Stream Nat
filter p (a :: as) = if p a then a :: (filter p as)
                     else filter p as

multiples : Nat -> Stream Nat
multiples n = iterate (\m => m + 2 * n) (n * n)

map : (a -> b) -> Stream a -> Stream b
map f (a :: as) = (f a) :: (map f as)

oddsFrom5 : Stream Nat
oddsFrom5 = iterate (\n => n + 2) 5

oddPrimes : Stream Nat
oddPrimes = 3 :: difference oddsFrom5 (unionAll (map multiples oddPrimes))

primes : Stream Nat
primes = 2 :: oddPrimes

export
prime : Nat -> Nat
prime 0 = 1
prime (S k) = index k primes
