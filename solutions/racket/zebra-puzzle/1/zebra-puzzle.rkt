#lang racket
(provide owns-zebra drinks-water)
(define houses
  (list
    (hash 'color 'yellow 'nationality 'Norwegian 'pet 'fox 'drink 'water 'smoke 'kools)
    (hash 'color 'blue 'nationality 'Ukrainian 'pet 'horse 'drink 'tea 'smoke 'chesterfields)
    (hash 'color 'red 'nationality 'Englishman 'pet 'snails 'drink 'milk 'smoke 'old_gold)
    (hash 'color 'green 'nationality 'Japanese 'pet 'zebra 'drink 'coffee 'smoke 'parliaments)
    (hash 'color 'ivory 'nationality 'Spaniard 'pet 'dog 'drink 'orange_juice 'smoke 'lucky_strike)))
(define (owns-zebra)
  (hash-ref (findf (lambda (house) (equal? (hash-ref house 'pet) 'zebra)) houses) 'nationality))
(define (drinks-water)
  (hash-ref (findf (lambda (house) (equal? (hash-ref house 'drink) 'water)) houses) 'nationality))
;; Helper function to find the first element in a list that satisfies a predicate
(define (findf pred lst)
  (cond
    [(null? lst) #f]
    [(pred (car lst)) (car lst)]
    [else (findf pred (cdr lst))]))