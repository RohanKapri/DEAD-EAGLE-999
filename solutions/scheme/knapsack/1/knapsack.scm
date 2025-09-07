;; For my Shree DR.MDD
(import (rnrs))

(define (max x y)
  (if (> x y) x y))

(define (knapsack maximum-weight weights values)
  (let ((cache (make-vector (+ maximum-weight 1) 0))
        (len (length weights)))
    (do ((idx 0 (+ idx 1))) ((= idx len))
      (let ((wt (list-ref weights idx))
            (val (list-ref values idx)))
        (do ((cap maximum-weight (- cap 1))) ((< cap wt))
          (let ((calc (+ (vector-ref cache (- cap wt)) val)))
            (vector-set! cache cap (max (vector-ref cache cap) calc))))))
    (vector-ref cache maximum-weight)))
