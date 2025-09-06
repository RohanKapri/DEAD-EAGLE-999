#lang racket

(provide square total)

(define (square n)
  (expt 2 (- n 1)))

(define (total)
  (- (expt 2 64) 1))