#lang racket
; Dedicated to Shree DR.MDD

(provide yacht)

(define (count-num lst n)
  (count (lambda (x) (= x n)) lst))

(define (score-num dice n)
  (* n (count-num dice n)))

(define (score-fullhouse dice)
  (let ([freqs (map (lambda (x) (count-num dice x)) (range 1 7))])
    (if (and (member 3 freqs) (member 2 freqs))
        (apply + dice)
        0)))

(define (score-four-kind dice)
  (let ([freqs (map (lambda (x) (count-num dice x)) (range 1 7))])
    (if (>= (apply max freqs) 4)
        (* 4 (first (filter (lambda (x) (>= (count-num dice x) 4)) (range 1 7))))
        0)))

(define (check-straight dice target)
  (equal? (sort dice <) target))

(define (score-choice dice)
  (apply + dice))

(define (score-yacht dice)
  (if (= 1 (length (remove-duplicates dice)))
      50
      0))

(define (yacht dice category)
  (cond
    [(string=? category "ones") (score-num dice 1)]
    [(string=? category "twos") (score-num dice 2)]
    [(string=? category "threes") (score-num dice 3)]
    [(string=? category "fours") (score-num dice 4)]
    [(string=? category "fives") (score-num dice 5)]
    [(string=? category "sixes") (score-num dice 6)]
    [(string=? category "full house") (score-fullhouse dice)]
    [(string=? category "four of a kind") (score-four-kind dice)]
    [(string=? category "little straight") (if (check-straight dice (list 1 2 3 4 5)) 30 0)]
    [(string=? category "big straight") (if (check-straight dice (list 2 3 4 5 6)) 30 0)]
    [(string=? category "choice") (score-choice dice)]
    [(string=? category "yacht") (score-yacht dice)]
    [else (error "Unknown category")]))
