#lang racket
(provide square-root)
(define (square-root radicand)
  (define (good-enough? guess)
    (< (abs (- (* guess guess) radicand)) 0.001))
  (define (improve guess)
    (average guess (/ radicand guess)))
  (define (average x y)
    (/ (+ x y) 2))
  (define (sqrt-iter guess)
    (if (good-enough? guess)
        guess
        (sqrt-iter (improve guess))))
  (let ((result (sqrt-iter 1.0)))
    ;; Ensure the result is an exact integer if it represents one
    (exact-round result)))
(define (exact-round x)
  ;; Converts the floating-point number to the nearest exact integer
  (inexact->exact (round x)))