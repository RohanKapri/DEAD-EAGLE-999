;; For my Shree DR.MDD
(import (rnrs))

(define (square idx)
  (if (or (< idx 1) (> idx 64))
      (error "Input out of range" idx)
      (expt 2 (- idx 1))))

(define (total)
  (- (expt 2 64) 1))

(define (total-iterative)
  (let loop ((pos 64) (acc 0))
    (if (> pos 0)
        (loop (- pos 1) (+ acc (square pos)))
        acc)))
