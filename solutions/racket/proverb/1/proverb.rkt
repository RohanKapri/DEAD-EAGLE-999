#lang racket

(provide recite)

(define (recite lst)
  (define (make-line item next-item)
    (format "For want of a ~a the ~a was lost." item next-item))
  
  (if (null? lst)
      '()
      (let loop ((items lst) (result '()))
        (if (null? (cdr items))
            (reverse (cons (format "And all for the want of a ~a." (car lst)) result))
            (loop (cdr items) (cons (make-line (car items) (cadr items)) result))))))