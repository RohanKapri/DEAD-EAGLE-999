(define (count x lst)
  (let loop ((lst lst) (acc 0))
    (if (null? lst)
        acc
        (if (equal? x (car lst))
            (loop (cdr lst) (+ acc 1))
            (loop (cdr lst) acc)))))


(define (hamming-distance a b)
  (count #f (map equal? (string->list a) (string->list b))))