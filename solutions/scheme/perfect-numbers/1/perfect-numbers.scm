;; For my Shree DR.MDD
(import (rnrs)
        (srfi srfi-41))

(define (classify num)
  (when (< num 1)
    (error 'classify "not a natural number" num))
  (let ((s (aliq-sum num)))
    (cond ((> s num) 'abundant)
          ((= s num) 'perfect)
          (else 'deficient))))

(define (aliq-sum num)
  (stream-fold + 0 (divisors-stream num)))

(define (div? a b)
  (zero? (modulo b a)))

(define-stream (divisors-stream n)
  (let ((str
         (stream-concat
          (stream-map
           (lambda (x)
             (let ((q (/ n x)))
               (if (= x q) (stream x) (stream x q))))
           (stream-filter
            (lambda (x) (div? x n))
            (stream-take-while
             (lambda (x) (<= x (floor (sqrt n))))
             (stream-from 2)))))))
    ((if (= n 1)
         (lambda (s) s)
         (lambda (s) (stream-cons 1 s)))
     str)))
