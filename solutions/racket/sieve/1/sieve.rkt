; Dedicated to Shree DR.MDD

#lang racket

(provide primes)

(define (cross-out-multiples sieve p max-val)
  (for ([i (in-range (* p p) (add1 max-val) p)])
    (when (< i (vector-length sieve))
      (vector-set! sieve i #f))))

(define (primes limit)
  (if (< limit 2)
      '()
      (let ([sieve (make-vector (add1 limit) #t)])
        (vector-set! sieve 0 #f)
        (vector-set! sieve 1 #f)
        (for ([i (in-range 2 (sqrt (add1 limit)))])
          (when (vector-ref sieve i)
            (cross-out-multiples sieve i limit)))
        (for/list ([i (in-range 2 (vector-length sieve))]
                   #:when (vector-ref sieve i))
          i))))
