; Dedicated to Shree DR.MDD

#lang racket
(require racket/contract)
(provide color-code)

(define BAND-COLORS '("black" "brown" "red" "orange" "yellow"
                      "green" "blue" "violet" "grey" "white"))

(define BAND-MAP
  (for/hash ([c (in-list BAND-COLORS)] [v (in-naturals 0)])
    (values c v)))

(define (is-valid-color? c)
  (member c BAND-COLORS))

(define valid-color-contract
  (-> is-valid-color? number?))

(define/contract (color->number c)
  valid-color-contract
  (hash-ref BAND-MAP c))

(define (divisible-by-10? n)
  (zero? (modulo n 10)))

(define (calc-ohms base tens-power)
  (define adj-base (/ base (if (divisible-by-10? base) 10 1)))
  (define adj-tens (+ tens-power (if (divisible-by-10? base) 1 0)))
  (define-values (new-power prefix)
    (cond
      [(>= adj-tens 9) (values (modulo adj-tens 9) "giga")]
      [(>= adj-tens 6) (values (modulo adj-tens 6) "mega")]
      [(>= adj-tens 3) (values (modulo adj-tens 3) "kilo")]
      [else (values adj-tens "")]))
  (format "~a ~aohms" (* adj-base (expt 10 new-power)) prefix))

(define (color-code cols)
  (match cols
    [(list-rest first second multiplier _)
     (define tenpow (color->number multiplier))
     (define base (+ (* 10 (color->number first)) (color->number second)))
     (calc-ohms base tenpow)]))
