#lang racket

(provide sum-of-squares square-of-sum difference)

(define (square-of-sum n)
  (sqr (* 1/2 n (add1 n))))

(define (sum-of-squares n)
  (* 1/6 n (add1 n) (+ n n 1)))

(define (difference n)
  (* 1/12 n (sub1 n) (add1 n) (+ n n n 2)))