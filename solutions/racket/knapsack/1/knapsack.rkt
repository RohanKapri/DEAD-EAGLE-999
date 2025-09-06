#lang racket

(provide item maximum-value)

(struct item (weight value) #:transparent)

(define (maximum-value maximum-weight items)
  (let ([dp (make-vector (add1 maximum-weight) 0)])
    (for ([it (in-list items)])
      (for ([w (in-range maximum-weight -1 -1)])
        (when (>= w (item-weight it))
          (let ([new-val (+ (vector-ref dp (- w (item-weight it))) (item-value it))])
            (vector-set! dp w (max (vector-ref dp w) new-val))))))
    (vector-ref dp maximum-weight)))