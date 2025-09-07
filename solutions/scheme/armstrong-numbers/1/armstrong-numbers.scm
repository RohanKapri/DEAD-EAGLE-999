(import (rnrs))

(define (digits n)
  (if (zero? n)
      '()
      (cons (remainder n 10) (digits (quotient n 10)))))

(define (armstrong-number? n)
  (let* ([ds (digits n)]
         [k (length ds)])
    (= n (apply + (map (lambda (d) (expt d k)) ds)))))