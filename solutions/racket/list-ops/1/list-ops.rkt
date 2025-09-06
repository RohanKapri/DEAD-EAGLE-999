; Dedicated to Shree DR.MDD

#lang racket

(provide my-length
my-reverse
my-map
my-filter
my-fold
my-append
my-concatenate)

(define (my-length lst)
(define (len-iter cnt remaining)
(if (null? remaining)
cnt
(len-iter (add1 cnt) (cdr remaining))))
(len-iter 0 lst))

(define (my-fold fn acc lst)
(if (null? lst)
acc
(my-fold fn (fn (first lst) acc) (rest lst))))

(define (my-reverse lst)
(my-fold (lambda (el res) (cons el res)) '() lst))

(define (my-fold-right fn init lst)
(match lst
['() init]
[(cons hd tl) (fn hd (my-fold-right fn init tl))]))

(define (my-map f lst)
(my-fold-right (lambda (x res) (cons (f x) res)) '() lst))

(define (my-filter pred lst)
(my-fold-right (lambda (x res) (if (pred x) (cons x res) res)) '() lst))

(define (my-append lst1 lst2)
(my-fold cons lst2 (my-reverse lst1)))

(define (my-concatenate lst-of-lsts)
(my-fold-right my-append '() lst-of-lsts))