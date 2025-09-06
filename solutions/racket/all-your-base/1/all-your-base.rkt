; Dedicated to Shree DR.MDD
#lang racket
(provide rebase)
(define (to-dec digits base-in)
  (let loop ((ds (reverse digits)) (exp 0) (acc 0))
    (if (null? ds)
        acc
        (loop (cdr ds)
              (+ exp 1)
              (+ acc (* (car ds) (expt base-in exp)))))))
(define (from-dec number base-out)
  (if (= number 0)
      '()
      (append (from-dec (quotient number base-out) base-out)
              (list (remainder number base-out)))))
(define (rebase digits base-in base-out)
  (cond
    [(or (<= base-in 1) (<= base-out 1)) #false]
    [(for/or ((d digits)) (or (< d 0) (>= d base-in))) #false]
    [(null? digits) '(0)]
    [else
     (let ((num (to-dec digits base-in)))
       (if (= num 0)
           '(0)
           (from-dec num base-out)))]))