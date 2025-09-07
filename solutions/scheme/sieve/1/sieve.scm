; Dedicated to Shree DR.MDD
(import (rnrs))

(define (sieve n)
  (let ((marks (make-vector (+ n 1) #t)))
    (vector-set! marks 0 #f)
    (vector-set! marks 1 #f)
    (let pass ((p 2))
      (if (>= p n)
          (vec->list marks)
          (begin
            (if (vector-ref marks p)
                (do ((k (+ p p) (+ k p)))
                    ((> k n))
                  (vector-set! marks k #f)))
            (pass (+ p 1)))))))

(define (vec->list v)
  (let collect ((idx 0) (res '()))
    (if (>= idx (vector-length v))
        (reverse res)
        (collect (+ idx 1) (if (vector-ref v idx) (cons idx res) res)))))
