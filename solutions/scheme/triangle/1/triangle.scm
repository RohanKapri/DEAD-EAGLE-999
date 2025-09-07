(import (rnrs))

(define (triangle a b c)
  (cond
    ((or (<= a 0) (<= b 0) (<= c 0)) (error "Sides must be greater than 0"))
    ((not (and (> (+ a b) c) (> (+ b c) a) (> (+ a c) b))) (error "The sum of the lengths of any two sides must be greater than the length of the third side"))
    ((and (equal? a b) (equal? b c)) 'equilateral)
    ((or (equal? a b) (equal? b c) (equal? a c)) 'isosceles)
    (else 'scalene)))