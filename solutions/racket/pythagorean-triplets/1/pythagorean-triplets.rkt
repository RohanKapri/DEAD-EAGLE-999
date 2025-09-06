#lang racket

(provide triplets-with-sum)

(define (triplets-with-sum p)
  (for*/list ([a (in-range 1 (quotient p 3))]
              [b (in-value (/ (* p (- p (* 2 a))) 
                              (* 2 (- p a))))]
              #:when (and (integer? b) (> b a))
              [triplet (in-value (let ([c (- p a b)])
                                   (and (> c b)
                                        (= (+ (* a a) (* b b)) (* c c))
                                        (list a b c))))]
              #:when triplet)
    triplet))