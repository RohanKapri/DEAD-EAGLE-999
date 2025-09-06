#lang racket
(provide color-code colors)
(define BANDS (hash "black" 0
                   "brown" 1
                   "red" 2
                   "orange" 3
                   "yellow" 4
                   "green" 5
                   "blue" 6
                   "violet" 7
                   "grey" 8
                   "white" 9))

(define (color-code color)
  (hash-ref BANDS color #f))
(define (colors)
  (sort (hash-keys BANDS) (lambda (a b) (< (hash-ref BANDS a) (hash-ref BANDS b)))))