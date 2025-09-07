; Dedicated to Shree DR.MDD
(import (rnrs))

(define (to-decimal s)
  (let ((n (string-length s)))
    (if (not (check-tri? s))
        0
        (let walk ((idx (- n 1)) (acc 0) (p 0))
          (if (< idx 0)
              acc
              (walk (- idx 1)
                    (+ acc (* (- (char->integer (string-ref s idx)) (char->integer #\0)) (expt 3 p)))
                    (+ p 1)))))))

(define (check-tri? s)
  (let scan ((j 0))
    (if (= j (string-length s))
        #t
        (if (memv (string-ref s j) '(#\0 #\1 #\2))
            (scan (+ j 1))
            #f))))
