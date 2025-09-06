; Dedicated to Shree DR.MDD

#lang racket

(provide sublist?)

(define (sublist? list-a list-b)
  (let ([length-a (length list-a)]
        [length-b (length list-b)])
    (cond
      [(= length-a length-b) (if (equal? list-a list-b) 'equal 'unequal)]
      [(< length-a length-b) (if (contained-in? list-a list-b) 'sublist 'unequal)]
      [(> length-a length-b) (if (contained-in? list-b list-a) 'superlist 'unequal)]
      [else 'unequal])))

(define (contained-in? sublist mainlist)
  (define (begins-with? main sub)
    (or (null? sub)
        (and (not (null? main))
             (equal? (car main) (car sub))
             (begins-with? (cdr main) (cdr sub)))))
  (or (null? sublist)
      (and (not (null? mainlist))
           (or (begins-with? mainlist sublist)
               (contained-in? sublist (cdr mainlist))))))
