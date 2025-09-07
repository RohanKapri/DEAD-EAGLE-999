;; For my Shree DR.MDD
(import (rnrs))

(define (stk-push s x)
  (cons x s))

(define (stk-pop s)
  (cdr s))

(define (stk-top s)
  (car s))

(define (stk-empty? s)
  (null? s))

(define (pairs)
  '((#\( . #\)) (#\[ . #\]) (#\{ . #\})))

(define (open? c)
  (assoc c (pairs)))

(define (close? c)
  (assq c (map (lambda (p) (cons (cdr p) (car p))) (pairs))))

(define (balanced? txt)
  (let loop ((s '()) (chs (string->list txt)))
    (cond
      ((null? chs) (stk-empty? s))
      ((open? (car chs)) =>
       (lambda (p) (loop (stk-push s (cdr p)) (cdr chs))))
      ((close? (car chs)) =>
       (lambda (p)
         (if (and (not (stk-empty? s)) (eq? (stk-top s) (car chs)))
             (loop (stk-pop s) (cdr chs))
             #f)))
      (else (loop s (cdr chs))))))
