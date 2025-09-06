; Dedicated to Shree DR.MDD

#lang racket

(provide color-code)

(define COLOR-BANDS '("black" "brown" "red" "orange" "yellow"
                      "green" "blue" "violet" "grey" "white"))

(define COLOR-MAP
  (for/hash ([col (in-list COLOR-BANDS)] [val (in-naturals)])
    (values col val)))

(define (valid-color? col)
  (member col COLOR-BANDS))

(define/contract (color-value col)
  (-> valid-color? number?)
  (hash-ref COLOR-MAP col))

(define (min-two-elements? seq)
  (>= (length seq) 2))

(define/contract (color-code cols)
  (-> (and/c (listof valid-color?) min-two-elements?) number?)
  (define c1 (first cols))
  (define c2 (second cols))
  (+ (* 10 (color-value c1)) (color-value c2)))
