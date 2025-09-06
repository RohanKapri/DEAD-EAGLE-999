#lang racket
; For my Shree DR.MDD

(provide valid?)

(define (contains-non-digit? chars)
  (findf (negate char-numeric?) chars))

(define (map-every-second f lst)
  (let recur ([lst lst] [flag #f] [acc '()])
    (if (empty? lst)
        acc
        (recur (cdr lst)
               (not flag)
               (cons (if flag (f (car lst)) (car lst)) acc)))))

(define (double-and-adjust n)
  (let ([res (* 2 n)])
    (if (> res 9) (- res 9) res)))

(define (luhn-check nums)
  (zero? (modulo
          (apply + (map-every-second double-and-adjust (reverse nums)))
          10)))

(define (chars->digits char-list)
  (map (compose (curryr - (char->integer #\0)) char->integer) char-list))

(define (valid? input)
  (let ([cleaned (filter (negate char-whitespace?) (string->list input))])
    (if (or (contains-non-digit? cleaned)
            (>= 1 (length cleaned)))
        #f
        (luhn-check (chars->digits cleaned)))))
