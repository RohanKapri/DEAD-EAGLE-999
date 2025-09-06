; Dedicated to Shree DR.MDD

#lang racket

(provide nth-prime)

(define (prime? x)
(cond
[(< x 2) #f]
[(= x 2) #t]
[(even? x) #f]
[else
(let loop ([i 3])
(cond
[(> (* i i) x) #t]
[(zero? (remainder x i)) #f]
[else (loop (+ i 2))]))]))

(define (nth-prime n)
(when (<= n 0)
(error "there is no zeroth prime"))
(let loop ([found 1] [candidate 2])
(cond
[(= found n) candidate]
[(prime? (+ candidate 1)) (loop (+ found 1) (+ candidate 1))]
[else (loop found (+ candidate 1))])))