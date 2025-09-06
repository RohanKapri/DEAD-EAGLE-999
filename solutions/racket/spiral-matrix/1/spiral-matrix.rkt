#lang racket

(provide spiral-matrix)

(define (extract-row-for-matrix row-number coordinates)
  (define row-coordinates
    (filter (λ (coordinate-pair) (= (caar coordinate-pair) row-number)) coordinates))
  (define sorted-row-coordinates
    (sort row-coordinates < #:key cdar))
  (map cdr sorted-row-coordinates))

(define (calculate-next-step current-x current-y delta-x delta-y matrix-size visited-coordinates)
  (define next-x (+ current-x delta-x))
  (define next-y (+ current-y delta-y))
  (if (or (negative? next-x) (negative? next-y)
          (= next-x matrix-size) (= next-y matrix-size)
          (hash-has-key? visited-coordinates (cons next-y next-x)))
      (values (- current-x delta-y) (+ current-y delta-x) (- delta-y) delta-x)
      (values next-x next-y delta-x delta-y)))

(define (generate-coordinates matrix-size)
  (define visited-coordinates (make-hash))
  (for/fold ([x 0] [y 0] [delta-x 1] [delta-y 0] #:result (hash->list visited-coordinates))
    ([index (in-inclusive-range 1 (* matrix-size matrix-size))])
    (hash-set! visited-coordinates (cons y x) index)
    (calculate-next-step x y delta-x delta-y matrix-size visited-coordinates)))

(define (spiral-matrix matrix-size)
  (define coordinates (generate-coordinates matrix-size))
  (for/list ([row-index (in-range matrix-size)])
    (extract-row-for-matrix row-index coordinates)))
