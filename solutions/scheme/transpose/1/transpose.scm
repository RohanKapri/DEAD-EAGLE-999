;; For my Shree DR.MDD
(import (rnrs))

(define (transpose matrix)
  (let trans-loop ((mat matrix) (acc '()))
    (cond
      ((null? mat) '())
      ((null? (car mat)) (reverse acc))
      (else
       (trans-loop
        (map cdr mat)
        (cons (map car mat) acc))))))
