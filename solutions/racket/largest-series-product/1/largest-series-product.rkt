#lang racket
(provide largest-product)
(define (digit->int char)
  (- (char->integer char) (char->integer #\0)))
(define (product-of-series series)
  (apply * (map digit->int (string->list series))))
(define (largest-product digits span)
  (cond
    [(or (< span 0) (> span (string-length digits)))
     (error "Span must be non-negative and not longer than the string length")]
    [(not (regexp-match #rx"^[0-9]*$" digits))
     (error "Input must only contain digits")]
    [(= span 0) 1]
    [else
     (let loop ([i 0] [max-product 0])
       (if (> (+ i span) (string-length digits))
           max-product
           (let ([product (product-of-series (substring digits i (+ i span)))])
             (loop (add1 i) (max max-product product)))))]))