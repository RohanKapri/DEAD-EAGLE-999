#lang racket

(provide number->eggs)

(define (number->eggs n)
  (define (count-bits n)
    (if (zero? n)
        0
        (+ (remainder n 2) (count-bits (quotient n 2)))))
  (count-bits n))