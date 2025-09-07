(import (rnrs))

(define (factorize n)
  (let loop ((n n) (i 2) (factors '()))
    (cond
      ((= n 1) (reverse factors))
      ((= (modulo n i) 0) (loop (/ n i) i (cons i factors)))
      (else (loop n (+ i 1) factors)))))