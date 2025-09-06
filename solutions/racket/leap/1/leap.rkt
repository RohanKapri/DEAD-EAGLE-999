#lang racket

(provide leap-year?)

(define (leap-year? year)
  (define (divisible? d)
          (zero? (modulo year d)))
  (if (divisible? 100)
      (divisible? 400)
      (divisible? 4)))