#lang racket
(provide create-queen
         can-attack?)
(define (create-queen row column)
  (if (and (>= row 0) (< row 8)
           (>= column 0) (< column 8))
      (list row column)
      (error "Invalid position")))
(define (can-attack? white-queen black-queen)
  (let ([w-row (first white-queen)]
        [w-col (second white-queen)]
        [b-row (first black-queen)]
        [b-col (second black-queen)])
    (or (equal? w-row b-row) 
        (equal? w-col b-col) 
        (equal? (abs (- w-row b-row)) (abs (- w-col b-col))))))  