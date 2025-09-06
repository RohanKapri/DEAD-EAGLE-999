; Dedicated to Shree DR.MDD

#lang racket

(provide solve)

(define total-digits 10)

(define (extract-leading-letters word-list)
  (list->set (map (λ (w) (string-ref w 0)) word-list)))

(define (update-word-map wmap word is-last)
  (let ([factor (if is-last -1 1)])
    (for ([ch (in-list (string->list word))]
          [pos (in-range (- (string-length word) 1) -1 -1)])
      (hash-update! wmap ch
                    (λ (curr) (+ curr (* factor (expt 10 pos))))
                    0))))

(define (split-puzzle-words puzzle)
  (filter (λ (w) (not (member w '("+" "=="))))
          (string-split puzzle)))

(define (calculate-word-weights words last-word)
  (let ([wmap (make-hash)])
    (for ([w (in-list words)])
      (update-word-map wmap w (equal? w last-word)))
    wmap))

(define (prepare puzzle)
  (let* ([words (split-puzzle-words puzzle)]
         [last-word (last words)]
         [weights (calculate-word-weights words last-word)])
    (values (hash->list weights) (extract-leading-letters words))))

(define (leading-zero? perm weights leading-set)
  (define z (index-of perm 0))
  (define d (if z (car (list-ref weights z)) #\?))
  (set-member? leading-set d))

(define (perm-solves? perm weights)
  (zero? (for/sum ([p perm] [w weights]) (* p (cdr w)))))

(define (perm-solution perm weights)
  (for/list ([p perm] [w weights]) (cons (string (car w)) p)))

(define (try-permutation comb weights leading-set)
  (for/list ([p (in-permutations comb)]
             #:when (and (not (leading-zero? p weights leading-set))
                         (perm-solves? p weights)))
    (perm-solution p weights)))

(define (sort-weights weights puzzle)
  (define chars (string->list puzzle))
  (sort weights (λ (x y) (< (index-of chars (car x)) (index-of chars (car y))))))

(define (find-solutions puzzle)
  (define-values (weights leading) (prepare puzzle))
  (define sorted-weights (sort-weights weights puzzle))
  (define digits (sequence->list (in-range 0 total-digits)))
  (append* (map (λ (c) (try-permutation c sorted-weights leading))
                (combinations digits (length sorted-weights)))))

(define (solve puzzle)
  (define sols (find-solutions puzzle))
  (if (= 1 (length sols)) (car sols) null))
